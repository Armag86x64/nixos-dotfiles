#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Output functions
error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to select disk
select_disk() {
    echo
    info "Available disks in system:"
    echo "----------------------------------------"
    lsblk -d -o NAME,SIZE,MODEL | grep -v "^loop"
    echo "----------------------------------------"
    echo
    
    # Get list of disks (excluding loop devices)
    disks=($(lsblk -d -n -o NAME | grep -v "^loop"))
    
    if [[ ${#disks[@]} -eq 0 ]]; then
        error "No disks found in system"
        exit 1
    fi
    
    PS3="Select disk number for installation: "
    select disk in "${disks[@]}"; do
        if [[ -n "$disk" ]]; then
            selected_disk="/dev/$disk"
            info "Selected disk: $selected_disk"
            break
        else
            warning "Invalid choice. Try again."
        fi
    done
}

# Function to check if disk is empty
is_disk_empty() {
    local disk=$1
    # Check number of partitions on disk
    local partitions=$(lsblk -n -o NAME "$disk" | wc -l)
    
    if [[ $partitions -le 1 ]]; then
        return 0  # Disk is empty
    else
        return 1  # Disk has partitions
    fi
}

# Function to confirm disk wipe
confirm_disk_wipe() {
    local disk=$1
    
    warning "Disk $disk is NOT empty! Existing partitions detected."
    echo "Disk contents:"
    lsblk "$disk"
    echo
    
    read -p "Are you sure you want to wipe ENTIRE disk $disk and install NixOS on it? (yes/NO): " confirm
    if [[ "$confirm" != "yes" ]]; then
        error "Installation cancelled by user"
        exit 0
    fi
    
    warning "Full disk wipe will be performed on $disk"
    read -p "Final confirmation: type 'ERASE ALL DATA' to continue: " final_confirm
    if [[ "$final_confirm" != "ERASE ALL DATA" ]]; then
        error "Installation cancelled"
        exit 0
    fi
    
    success "Confirmed wipe of disk $disk"
}

# Check root privileges
if [[ $EUID -ne 0 ]]; then
    error "Script must be run with root privileges (sudo)"
    exit 1
fi

# Password prompts
echo
info "User Password Setup"
echo "================================="

# Root password
while true; do
    read -s -p "Enter password for root: " root_password
    echo
    read -s -p "Confirm password for root: " root_password_confirm
    echo
    
    if [[ "$root_password" == "$root_password_confirm" ]] && [[ -n "$root_password" ]]; then
        break
    else
        warning "Passwords do not match or are empty. Try again."
    fi
done

# Soundwave user password
while true; do
    read -s -p "Enter password for user soundwave: " user_password
    echo
    read -s -p "Confirm password for user soundwave: " user_password_confirm
    echo
    
    if [[ "$user_password" == "$user_password_confirm" ]] && [[ -n "$user_password" ]]; then
        break
    else
        warning "Passwords do not match or are empty. Try again."
    fi
done

# Select disk
select_disk

# Check disk for existing data
if ! is_disk_empty "$selected_disk"; then
    confirm_disk_wipe "$selected_disk"
fi

# Create temporary directory
temp_dir=$(mktemp -d)
cd "$temp_dir" || exit 1

info "Working directory: $temp_dir"

# Step 1: Install required packages in live system
info "Installing required packages (git, disko)..."

# Update channels
nix-channel --update

# Install git and other tools via nix-shell
nix-shell -p git nixos-generators --run "echo 'Packages installed'"

if ! command -v git &> /dev/null; then
    error "Failed to install git"
    exit 1
fi

success "Required packages installed"

# Step 2: Clone repository with configuration
info "Cloning nixos-dotfiles repository..."
git clone -b feature/builder https://github.com/Armag86x64/nixos-dotfiles.git

if [[ ! -d "nixos-dotfiles" ]]; then
    error "Failed to clone repository"
    exit 1
fi

success "Repository cloned"

# Step 3: Create temporary disk-config.nix with correct device
info "Preparing disk configuration..."

# Create temporary disk config file with substituted device
temp_disk_config="$temp_dir/disk-config-temp.nix"

cat > "$temp_disk_config" << EOF
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "$selected_disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/mnt/boot";
                mountOptions = [ "defaults" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt";
              };
            };
          };
        };
      };
    };
  };
}
EOF

success "Disk configuration created for $selected_disk"

# Step 4: Partition disks using disko
info "Partitioning disks with disko..."

# Run disko
nix run github:nix-community/disko -- --mode disko "$temp_disk_config"

if [[ $? -ne 0 ]]; then
    error "Error during disk partitioning"
    exit 1
fi

success "Disk partitioning completed"

# Step 5: Check mounting
info "Checking mount..."

if ! mountpoint -q /mnt; then
    error "/mnt is not mounted. Something went wrong with partitioning"
    exit 1
fi

success "System mounted at /mnt"

# Step 6: Generate hardware-configuration.nix
info "Generating hardware-configuration.nix..."

# Create directory for hardware config
mkdir -p /mnt/etc/nixos

# Generate new configuration
nixos-generate-config --root /mnt

if [[ -f "/mnt/etc/nixos/hardware-configuration.nix" ]]; then
    success "hardware-configuration.nix generated"
else
    error "Failed to generate hardware-configuration.nix"
    exit 1
fi

# Step 7: Copy configuration to target system
info "Copying configuration to system..."

# Create soundwave user in target system (temporarily, for copying)
nixos-enter --root /mnt --command "useradd -m -G wheel -s /bin/bash soundwave 2>/dev/null || true"

# Copy configuration to home directory
cp -r nixos-dotfiles /mnt/home/soundwave/nixos-config
chown -R 1000:100 /mnt/home/soundwave/nixos-config  # 1000 is typical UID for first user

success "Configuration copied to /mnt/home/soundwave/nixos-config"

# Step 8: Replace hardware-configuration.nix in config
info "Replacing hardware-configuration.nix..."

# Remove old and copy new
rm -f /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix

success "hardware-configuration.nix updated"

# Step 9: Create symbolic link in /etc/nixos
info "Creating symbolic link /etc/nixos..."

# Remove existing link/directory in target system
nixos-enter --root /mnt --command "rm -rf /etc/nixos"

# Create symbolic link
nixos-enter --root /mnt --command "ln -s /home/soundwave/nixos-config /etc/nixos"

success "Symbolic link created"

# Step 10: Set passwords in target system
info "Setting user passwords..."

# Set root password
echo "root:$root_password" | nixos-enter --root /mnt --command "chpasswd"

# Set soundwave password
echo "soundwave:$user_password" | nixos-enter --root /mnt --command "chpasswd"

success "Passwords set"

# Step 11: Install system
info "Starting NixOS installation..."
echo "=========================================="
echo "This may take several minutes..."
echo "=========================================="

# Install via flake
nixos-install --flake "/mnt/home/soundwave/nixos-config#altair"

if [[ $? -eq 0 ]]; then
    success "=========================================="
    success "INSTALLATION COMPLETED SUCCESSFULLY!"
    success "=========================================="
    echo
    success "Hostname: altair"
    success "User: soundwave"
    success "Password for soundwave and root has been set"
    echo
    warning "IMPORTANT: After reboot, run:"
    warning "  sudo nixos-rebuild switch --flake /home/soundwave/nixos-config#altair"
    echo
    read -p "Press Enter to reboot or Ctrl+C to exit..."
    reboot
else
    error "Error during NixOS installation"
    error "Check the logs above and try again"
    exit 1
fi

# Cleanup
cd /
rm -rf "$temp_dir"
