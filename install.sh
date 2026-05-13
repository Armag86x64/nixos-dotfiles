#!/usr/bin/env bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функции для вывода
error() {
    echo -e "${RED}[ОШИБКА]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[УСПЕХ]${NC} $1"
}

info() {
    echo -e "${BLUE}[ИНФО]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[ПРЕДУПРЕЖДЕНИЕ]${NC} $1"
}

# Функция для выбора диска
select_disk() {
    echo
    info "Доступные диски в системе:"
    echo "----------------------------------------"
    lsblk -d -o NAME,SIZE,MODEL | grep -v "^loop"
    echo "----------------------------------------"
    echo
    
    # Получаем список дисков (исключая loop устройства)
    disks=($(lsblk -d -n -o NAME | grep -v "^loop"))
    
    if [[ ${#disks[@]} -eq 0 ]]; then
        error "Не найдено ни одного диска в системе"
        exit 1
    fi
    
    PS3="Выберите номер диска для установки: "
    select disk in "${disks[@]}"; do
        if [[ -n "$disk" ]]; then
            selected_disk="/dev/$disk"
            info "Выбран диск: $selected_disk"
            break
        else
            warning "Неверный выбор. Попробуйте снова."
        fi
    done
}

# Функция для проверки, пустой ли диск
is_disk_empty() {
    local disk=$1
    # Проверяем количество разделов на диске
    local partitions=$(lsblk -n -o NAME "$disk" | wc -l)
    
    if [[ $partitions -le 1 ]]; then
        return 0  # Диск пустой
    else
        return 1  # На диске есть разделы
    fi
}

# Функция для подтверждения очистки диска
confirm_disk_wipe() {
    local disk=$1
    
    warning "Диск $disk НЕ пустой! На нём обнаружены существующие разделы."
    echo "Содержимое диска:"
    lsblk "$disk"
    echo
    
    read -p "Вы уверены, что хотите стереть ВЕСЬ диск $disk и установить на него NixOS? (yes/NO): " confirm
    if [[ "$confirm" != "yes" ]]; then
        error "Установка отменена пользователем"
        exit 0
    fi
    
    warning "Будет выполнена полная очистка диска $disk"
    read -p "Последнее подтверждение: введите 'ERASE ALL DATA' для продолжения: " final_confirm
    if [[ "$final_confirm" != "ERASE ALL DATA" ]]; then
        error "Установка отменена"
        exit 0
    fi
    
    success "Подтверждена очистка диска $disk"
}

# Проверка прав root
if [[ $EUID -ne 0 ]]; then
    error "Скрипт должен запускаться с правами root (sudo)"
    exit 1
fi

# Запрос паролей
echo
info "Настройка паролей пользователей"
echo "================================="

# Пароль для root
while true; do
    read -s -p "Введите пароль для root: " root_password
    echo
    read -s -p "Подтвердите пароль для root: " root_password_confirm
    echo
    
    if [[ "$root_password" == "$root_password_confirm" ]] && [[ -n "$root_password" ]]; then
        break
    else
        warning "Пароли не совпадают или пустые. Попробуйте снова."
    fi
done

# Пароль для soundwave
while true; do
    read -s -p "Введите пароль для пользователя soundwave: " user_password
    echo
    read -s -p "Подтвердите пароль для пользователя soundwave: " user_password_confirm
    echo
    
    if [[ "$user_password" == "$user_password_confirm" ]] && [[ -n "$user_password" ]]; then
        break
    else
        warning "Пароли не совпадают или пустые. Попробуйте снова."
    fi
done

# Выбор диска
select_disk

# Проверка диска на наличие данных
if ! is_disk_empty "$selected_disk"; then
    confirm_disk_wipe "$selected_disk"
fi

# Создание временной директории
temp_dir=$(mktemp -d)
cd "$temp_dir" || exit 1

info "Рабочая директория: $temp_dir"

# Шаг 1: Установка необходимых пакетов в live-системе
info "Установка необходимых пакетов (git, disko)..."

# Обновление каналов
nix-channel --update

# Установка git и других инструментов через nix-shell
nix-shell -p git nixos-generators --run "echo 'Packages installed'"

if ! command -v git &> /dev/null; then
    error "Не удалось установить git"
    exit 1
fi

success "Необходимые пакеты установлены"

# Шаг 2: Клонирование репозитория с конфигурацией
info "Клонирование репозитория nixos-dotfiles..."
git clone https://github.com/Armag86x64/nixos-dotfiles.git

if [[ ! -d "nixos-dotfiles" ]]; then
    error "Не удалось клонировать репозиторий"
    exit 1
fi

success "Репозиторий склонирован"

# Шаг 3: Создание временного disk-config.nix с правильным устройством
info "Подготовка конфигурации диска..."

# Создаем временный файл конфигурации диска с подставленным устройством
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

success "Конфигурация диска создана для $selected_disk"

# Шаг 4: Разметка дисков через disko
info "Выполняется разметка дисков с помощью disko..."

# Запуск disko
nix run github:nix-community/disko -- --mode disko "$temp_disk_config"

if [[ $? -ne 0 ]]; then
    error "Ошибка при разметке дисков"
    exit 1
fi

success "Разметка дисков завершена"

# Шаг 5: Монтирование (disko уже смонтировал всё в /mnt, но проверим)
info "Проверка монтирования..."

if ! mountpoint -q /mnt; then
    error "/mnt не смонтирован. Что-то пошло не так при разметке"
    exit 1
fi

success "Система смонтирована в /mnt"

# Шаг 6: Генерация hardware-configuration.nix
info "Генерация hardware-configuration.nix..."

# Создаем директорию для hardware конфигурации
mkdir -p /mnt/etc/nixos

# Генерируем новую конфигурацию
nixos-generate-config --root /mnt

if [[ -f "/mnt/etc/nixos/hardware-configuration.nix" ]]; then
    success "hardware-configuration.nix сгенерирован"
else
    error "Не удалось сгенерировать hardware-configuration.nix"
    exit 1
fi

# Шаг 7: Перенос конфигурации в целевую систему
info "Перенос конфигурации в систему..."

# Создаем пользователя soundwave в целевой системе (временно, для копирования)
nixos-enter --root /mnt --command "useradd -m -G wheel -s /bin/bash soundwave 2>/dev/null || true"

# Копируем конфигурацию в домашнюю директорию
cp -r nixos-dotfiles /mnt/home/soundwave/nixos-config
chown -R 1000:100 /mnt/home/soundwave/nixos-config  # 1000 - типичный UID первого пользователя

success "Конфигурация скопирована в /mnt/home/soundwave/nixos-config"

# Шаг 8: Замена hardware-configuration.nix в конфигурации
info "Замена hardware-configuration.nix..."

# Удаляем старый и копируем новый
rm -f /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/soundwave/nixos-config/main-configuration/hardware/hardware-configuration.nix

success "hardware-configuration.nix обновлен"

# Шаг 9: Создание символической ссылки в /etc/nixos
info "Создание символической ссылки /etc/nixos..."

# Удаляем существующую ссылку/директорию в целевой системе
nixos-enter --root /mnt --command "rm -rf /etc/nixos"

# Создаем символическую ссылку
nixos-enter --root /mnt --command "ln -s /home/soundwave/nixos-config /etc/nixos"

success "Символическая ссылка создана"

# Шаг 10: Установка паролей в целевой системе
info "Установка паролей пользователей..."

# Установка пароля root
echo "root:$root_password" | nixos-enter --root /mnt --command "chpasswd"

# Установка пароля soundwave
echo "soundwave:$user_password" | nixos-enter --root /mnt --command "chpasswd"

success "Пароли установлены"

# Шаг 11: Установка системы
info "Начинается установка NixOS..."
echo "=========================================="
echo "Это может занять несколько минут..."
echo "=========================================="

# Установка через flake
nixos-install --flake "/mnt/home/soundwave/nixos-config#altair"

if [[ $? -eq 0 ]]; then
    success "=========================================="
    success "УСТАНОВКА УСПЕШНО ЗАВЕРШЕНА!"
    success "=========================================="
    echo
    success "Имя хоста: altair"
    success "Пользователь: soundwave"
    success "Пароль для soundwave и root установлен"
    echo
    warning "ВАЖНО: После перезагрузки выполните:"
    warning "  sudo nixos-rebuild switch --flake /home/soundwave/nixos-config#altair"
    echo
    read -p "Нажмите Enter для перезагрузки или Ctrl+C для выхода..."
    reboot
else
    error "Ошибка при установке NixOS"
    error "Проверьте логи выше и попробуйте снова"
    exit 1
fi

# Очистка
cd /
rm -rf "$temp_dir"
