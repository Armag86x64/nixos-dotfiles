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

# Cleanup function for trap
cleanup() {
    info "Cleaning up..."
    umount -R /mnt 2>/dev/null || true
    if [[ -n "$temp_dir" && -d "$temp_dir" ]]; then
        rm -rf "$temp_dir"
    fi
}

# Function to enable nix experimental features globally
enable_nix_features() {
    mkdir -p /etc/nix
    if ! grep -q "experimental-features" /etc/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
        success "Nix experimental features enabled (nix-command and flakes)"
    fi
}

# Function to check internet connectivity
check_internet() {
    info "Checking internet connection..."
    if ! ping -c 1 github.com &> /dev/null; then
        error "No internet connection. Please configure network first."
        error "You can use: sudo systemctl start NetworkManager && nmtui"
        exit 1
    fi
    success "Internet connection detected"
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
    mapfile -t disks < <(lsblk -d -n -o NAME | grep -v "^loop")
    
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

# Set trap for cleanup
trap cleanup EXIT INT TERM

# Enable Nix experimental features
enable_nix_features

# Check internet connection
check_internet

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

# Install git and disko using nix profile
nix profile install nixpkgs#git nixpkgs#disko 2>/dev/null || nix-env -iA nixos.git nixos.disko

if ! command -v git &> /dev/null; then
    error "Failed to install git"
    exit 1
fi

if ! command -v disko &> /dev/null; then
    error "Failed to install disko"
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
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
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
disko --mode disko "$temp_disk_config"

if [[ $? -ne 0 ]]; then
    error "Error during disk partitioning"
    exit 1
fi

success "Disk partitioning completed"

# Step 5: Check mounting
info "Checking mount..."

# Wait a bit for mounts to settle
sleep 2

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

if [[ ! -f "/mnt/etc/nixos/hardware-configuration.nix" ]]; then
    error "Failed to generate hardware-configuration.nix"
    exit 1
fi

success "hardware-configuration.nix generated"

# Step 7: Copy configuration to target system
info "Copying configuration to system..."

mkdir -p /mnt/home/soundwave

if [[ ! -d "$temp_dir/nixos-dotfiles" ]]; then
    error "nixos-dotfiles not found at $temp_dir/nixos-dotfiles"
    ls -la "$temp_dir/"
    exit 1
fi

cp -r "$temp_dir/nixos-dotfiles" /mnt/home/soundwave/nixos-config

if [[ ! -d "/mnt/home/soundwave/nixos-config" ]]; then
    error "Failed to copy nixos-dotfiles to /mnt/home/soundwave/nixos-config"
    exit 1
fi

chown -R 1000:1000 /mnt/home/soundwave/nixos-config

info "Contents of nixos-config:"
find /mnt/home/soundwave/nixos-config -name "flake.nix" 2>/dev/null || echo "WARNING: flake.nix not found!"

success "Configuration copied to /mnt/home/soundwave/nixos-config"

success "Configuration copied to /mnt/home/soundwave/nixos-config"

# Step 8: Replace hardware-configuration.nix in config
info "Replacing hardware-configuration.nix..."

# Ensure hardware directory exists
mkdir -p /mnt/home/soundwave/nixos-config/main-configuration/hardware

# Remove old and copy new
rm -f /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix

if [[ ! -f "/mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix" ]]; then
    error "Failed to copy hardware-configuration.nix"
    exit 1
fi

success "hardware-configuration.nix updated"

# Step 9: Create symbolic link in /etc/nixos (robust version)
info "Creating symbolic link /etc/nixos..."

# Debug: Check what exists
info "Debug: Checking current state in /mnt"
ls -la /mnt/etc/ | grep nixos || echo "No nixos in /mnt/etc"
ls -la /mnt/home/soundwave/ | grep nixos-config || echo "No nixos-config in /mnt/home/soundwave"

# Ensure source directory exists
if [[ ! -d "/mnt/home/soundwave/nixos-config" ]]; then
    error "Source directory /mnt/home/soundwave/nixos-config does not exist!"
    exit 1
fi

# Remove existing file/directory/symlink (multiple methods for safety)
rm -rf /mnt/etc/nixos 2>/dev/null || true
unlink /mnt/etc/nixos 2>/dev/null || true

# Create the symlink directly on the host system (not through chroot)
info "Creating symlink directly on host system..."
if ln -sf /home/soundwave/nixos-config /mnt/etc/nixos; then
    success "Symbolic link created successfully"
    
    # Verify
    if [[ -L "/mnt/etc/nixos" ]]; then
        success "Symlink verified: $(ls -la /mnt/etc/nixos)"
    else
        warning "Symlink created but verification failed"
    fi
else
    error "Failed to create symlink"
    error "Check permissions: ls -la /mnt/etc/"
    exit 1
fi


info "Debug: checking copied config..."
find /mnt/home -name "flake.nix" 2>/dev/null || echo "flake.nix NOT FOUND anywhere under /mnt/home"
ls -la /mnt/home/soundwave/ 2>/dev/null || echo "/mnt/home/soundwave does not exist"

# Step 10: Install system
info "Starting NixOS installation..."
echo "=========================================="
echo "This may take several minutes..."
echo "=========================================="

mkdir -p /mnt/etc/nix
echo "experimental-features = nix-command flakes" > /mnt/etc/nix/nix.conf

# Hardcode the known path directly
flake_dir="/mnt/home/soundwave/nixos-config"

if [[ ! -f "$flake_dir/flake.nix" ]]; then
    error "flake.nix not found at $flake_dir/flake.nix"
    ls -la "$flake_dir/" 2>/dev/null || echo "Directory does not exist"
    exit 1
fi

info "Found flake at: $flake_dir"

nixos-install --flake "$flake_dir#altair" --no-root-passwd


# Step 11: Set passwords
info "Setting user passwords in the installed system..."

nixos-enter --root /mnt --command "echo 'root:$root_password' | chpasswd" && \
    success "Root password set" || error "Failed to set root password"

nixos-enter --root /mnt --command "echo 'soundwave:$user_password' | chpasswd" && \
    success "Soundwave password set" || error "Failed to set soundwave password"
