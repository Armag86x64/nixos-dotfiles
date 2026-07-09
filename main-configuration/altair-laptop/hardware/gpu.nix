{ unstable, ... }: {
    hardware.graphics = {
        enable = true;
        enable32Bit = true;      # Для установки 32-битных приложений
        extraPackages = with unstable; [
          intel-media-driver     # Аппаратное декодирование/кодирование видео(VA-API) для Intel Gen8 и новее 
          vpl-gpu-rt             # Среда выполнения (oneVPL Runtime) для ускорения видео на GPU Intel Tiger Lake и новее          
          intel-compute-runtime  # Вычисления OpenCL и Level Zero для вычислений на GPU(blender, иишка и прочие) 
          libvdpau-va-gl         # Мост-переводчик для запуска старых VDPAU-приложений через современный VA-API
          # intel-vaapi-driver   # Устаревший драйвер(i965) для старых GPU Intel Gen7 и ниже
        ];
    };

    # Переменные окружения для форсирования аппаратного ускорения
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";            # Принудительный выбор аппаратного видеоускорителя(драйвер смотреть через vainfo)
      VDPAU_DRIVER = "va_gl";               # Указывает видеопроигрывателям и браузерам, какой драйвер использовать для аппаратного декодирования видео через VDPAU
      MESA_LOADER_DRIVER_OVERRIDE = "iris"; # Принудительное указание драйвера для библиотеки Mesa
      NIXOS_OZONE_WL = "1";                 # Принудительный запуск chromium и electron-приложений через wayland
    };

    boot.kernelParams = [
      "i915.enable_guc=3"          # Активация микроконтроллеров Intel(GuC/HuC): включает аппаратное ускорение видео и разгружает CPU
      "i915.enable_fbc=1"          # FBC: сжимает графические данные в RAM, снижает нагрузку на шину памяти. ! Может вызывать артефакты 
      "i915.enable_psr=1"          # Энергосбережение: Если картинка на экране статична, видеокарта перестает постоянно пересылать кадры на дисплей
      # "video=eDP-1:1600x900M@60" # Принудительное назначение разрешения 1600x900 и частоты 60Hz
      # "i915.fastboot=1"          # Ускоренная загрузка: убирает мигание экрана, сохраняя графический режим BIOS/UEFI при старте. Возможен чёрный экран и артефакты
    ];
    
    environment.systemPackages = with unstable; [
        intel-gpu-tools # Команда: sudo intel_gpu_top
        libva-utils     # Команда: vainfo
        vulkan-tools    # Проверка Vulkan: vulkaninfo или vkcube
    ];
}
