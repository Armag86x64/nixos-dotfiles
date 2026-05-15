{ config, lib, pkgs, ... }: { 
    hardware.cpu.intel.updateMicrocode = true;

    # Основные сервисы термоконтроля
    services.thermald.enable = true;

    # System76 Scheduler: приоритизирует активные окна, делая интерфейс отзывчивым
    services.system76-scheduler.enable = true; 
    services.system76-scheduler.useStockConfig = true;
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # TLP: Главный инструмент оптимизации батареи
    services.power-profiles-daemon.enable = false; # Отключаем конфликтный сервис
    services.auto-cpufreq.enable = false;          # Отключаем, управление берет TLP
    powerManagement.powertop.enable = false;

    # Распределение прерываний между ядрами (важно для гибридной архитектуры)
    services.irqbalance.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        # Регулятор частоты для драйвера intel_pstate
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # EPP: нативная поддержка для процессоров Intel 12-14 поколений
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        # Отключаем Turbo Boost на батарее для экономии заряда (сберегает до 30% батареи)
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # Позволяем Intel Thread Director самому эффективно распределять задачи по P/E ядрам
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 100;

        # Интеллектуальное управление графикой Intel
        INTEL_GPU_MIN_FREQ_ON_AC = 300;
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_BOOST_ON_AC = 1;
        INTEL_GPU_BOOST_ON_BAT = 0; 

        # Энергосбережение периферии
        PCIE_ASPM_ON_BAT = "powersave";
        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        USB_AUTOSUSPEND = 1;
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      };
    };

    # Параметры ядра
    boot.kernelParams = [ 
      "intel_pstate=active"  # Явно форсируем современный драйвер pstate
      "pcie_aspm=force"      # Агрессивное энергосбережение линий PCIe
      # "loglevel=3"           # Скрывает некритичные ошибки ACPI BIOS из консоли при загрузке
    ];

    # Блокировка конфликтующих модулей
    # Исправляет циклическую ошибку "i801_smbus: SMBus is busy"
    boot.blacklistedKernelModules = [ "i801_smbus" ];

    # Полезные пакеты для мониторинга
    environment.systemPackages = with pkgs; [
        powertop
    ];
}
