{ unstable, ... }: {
    # Включаем графику (актуально для NixOS 24.11+)
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with unstable; [
          intel-media-driver   # Основной драйвер для видео (iHD)
          vpl-gpu-rt           # Runtime для новых приложений Intel (Video Processing Library)
          intel-compute-runtime # OpenCL для вычислений на GPU
          # intel-vaapi-driver   # Наследный драйвер для полной совместимости
          libvdpau-va-gl       # Прослойка для приложений, использующих VDPAU
        ];
    };

    # 2. Переменные окружения для форсирования аппаратного ускорения
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";    # Для старых плееров и софта
      NIXOS_OZONE_WL = "1";      # Chrome/VSCode/Discord нативно в Wayland
    
      # Исправляет артефакты в некоторых приложениях на Intel 13-го поколения
      MESA_LOADER_DRIVER_OVERRIDE = "iris"; 
    };

    # 3. Тонкая настройка ядра для экономии и производительности GPU 
    boot.kernelParams = [
      "i915.enable_guc=3"        # Планирование задач внутри GPU (уже было, отлично)
      "i915.enable_fbc=1"        # Сжатие данных в памяти (Frame Buffer Compression)
      "i915.enable_psr=1"        # Panel Self Refresh (Огромный плюс к батарее)
      #"i915.fastboot=1"          # Убирает мерцание при загрузке
      "video=eDP-1:1600x900M@60"

    ];
    
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    # Полезный софт для проверки
    environment.systemPackages = with unstable; [
        intel-gpu-tools # Команда: sudo intel_gpu_top
        libva-utils     # Команда: vainfo
        vulkan-tools    # Проверка Vulkan: vulkaninfo или vkcube
    ];
}

/*
На что обратить внимание:
i915.enable_psr=1: На некоторых редких матрицах Honor это может вызвать микро-мерцание курсора. Если заметите — измените на 0. Но в 95% случаев на моделях 2024-2025 годов это работает идеально и сильно бережет заряд.
Wayland: Поскольку вы используете NIXOS_OZONE_WL = "1", убедитесь, что ваш браузер (Chrome/Firefox) действительно использует аппаратное декодирование. В Firefox это включается через media.ffmpeg.vaapi.enabled в about:config.
*/
