{ unstable, ... }: { 
    hardware.cpu.intel.updateMicrocode = true;    # Автоматически обновляет прошивку микрокод CPU при каждой загрузке ос
    
    # Включает thermald - демон регулирования температуры
    services.thermald.enable = true;   

    # System76 Scheduler: приоритизирует активные окна, делая интерфейс отзывчивым
    services.system76-scheduler.enable = true; 

    # Использовать стандартную конфигурацию System76: демон будет автоматически отдавать приоритет процессора активному окну.
    services.system76-scheduler.useStockConfig = true; 

    # Включить динамическое управление профилями планировщика CFS в ядре Linux для снижения задержек в играх и программах.
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # Отключение конфликтных модулей(необходимо, чтобы работал tlp)
    services.power-profiles-daemon.enable = false;  # Отключает стандартный демон профилей питания
    services.auto-cpufreq.enable = false;           # Отключает автоматический регулятор частоты процессора auto-cpufreq
    powerManagement.powertop.enable = false;        # Отключает автоматическую оптимизацию энергосбережения от проги PowerTOP

    # Включает автоматическое распределение аппаратных прерываний по ядрам CPU
    services.irqbalance.enable = true;

    # TLP: Главный инструмент для управления батареей
    services.tlp = {
      enable = true;
      settings = {
        # Игнорировать ошибки конфигурации Intel в BIOS, чтобы thermald не отключался аварийно
        THERMALD_IGNORE_INVALID_INTEL_CONFIG = 1;
        /*
          ON_AC - при подключении к питанию
          ON_BAT - при отсутствии питания
        */ 

        # Регулятор частоты для драйвера intel_pstate
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # EPP: нативная поддержка для процессоров Intel 12-14 поколений
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        # Регуляция Turbo Boost(разгон ядер) на CPU
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # Позволяем Intel Thread Director самому эффективно распределять задачи по P/E ядрам
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 100;

        # Базовое управление графикой Intel
        INTEL_GPU_MAX_FREQ_ON_AC = 1400;
        INTEL_GPU_MAX_FREQ_ON_BAT = 800;
        INTEL_GPU_MIN_FREQ_ON_AC = 300;
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;

        # Для тяжёлой нагрузки и при скачках частот
        INTEL_GPU_BOOST_ON_AC = 1;
        INTEL_GPU_BOOST_ON_BAT = 0;   
        INTEL_GPU_BOOST_FREQ_ON_AC = 1400;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 800;

        # Пороги заряда:
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # Это защитит шину тачпада на любом современном ноутбуке Intel/AMD
        RUNTIME_PM_DRIVER_DENYLIST = "i2c_designware intel_lpss_pci";
        USB_EXCLUDE_HID = 1;

        # === Энергосбережение периферии ===

        # Энергосбережение шины PCIe на батарее (засыпание линий Wi-Fi, NVMe и графики)
        PCIE_ASPM_ON_BAT = "powersave";

        # Запрет отключения звукового чипа при питании от сети(нет задержек звука)
        SOUND_POWER_SAVE_ON_AC = 0;
        # Сон звуковой карты через 1 секунду бездействия на батарее(экономит заряд, но может вызывать щелчки)
        SOUND_POWER_SAVE_ON_BAT = 1;

        # Авто-отключение питания бездействующих USB-устройств (камеры, Bluetooth)
        USB_AUTOSUSPEND = 1;

        # Безопасный режим энергосбережения для SATA SSD/HDD при работе от батареи
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      };
    };

    # Параметры ядра
    boot.kernelParams = [ 
      "intel_pstate=active"         # Активация родного драйвера Intel для управления частотой и питанием ядер

      # УНИВЕРСАЛЬНЫЙ СТЭК ДЛЯ СТАБИЛИЗАЦИИ I2C/HID ТАЧПАДОВ:
      "i2c_designware.disable_pm=1" # Запрещаем засыпать контроллеру шины
      "acpi_osi=\"Windows 2015\""   # Информирует систему о том, что ОС - Windows, заставляет активировать шину i2c
 
      "loglevel=3"                  # Скрывает некритичные ошибки из консоли при загрузке
      "quiet"                       # Скрывает обычный лог загрузки
  
      # "pcie_aspm=force"           # Агрессивное энергосбережение линий PCIe, может приводить к отвалу WiFi и прочим проблемам
    ];

    boot.blacklistedKernelModules = [ "elan_i2c" ];

    environment.systemPackages = with unstable; [
      powertop  # Анализ энергопотребления(показывает расход батареи в Ваттах и "пожирателей" заряда)
      s-tui     # Мониторинг процессора в консоли (графики частот, температур, ватт и стресс-тест)
    ];
}
