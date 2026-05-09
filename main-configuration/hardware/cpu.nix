{ config, lib, pkgs, ... }: { 
    hardware.cpu.intel.updateMicrocode = true;

    # Основные сервисы
    services.thermald.enable = true;

    # System76 Scheduler: приоритизирует активные окна, делая интерфейс отзывчивым
    services.system76-scheduler.enable = true; 
    services.system76-scheduler.useStockConfig = true;
    services.system76-scheduler.settings.cfsProfiles.enable = true;


    # TLP: Главный инструмент оптимизации батареи (заменяет auto-cpufreq)
    services.power-profiles-daemon.enable = false; # Обязательно отключаем конфликт
    services.auto-cpufreq.enable = false;          # Отключаем, так как TLP берет управление на себя
    powerManagement.powertop.enable = false;

    # Распределение прерываний между ядрами (важно для гибридной архитектуры)
    services.irqbalance.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        # Регулятор частоты для драйвера intel_pstate
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # EPP: balance_performance для сети, balance_power для батареи
        # Это позволяет процессору буститься при компиляции, но быть экономным в простое
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        # Разрешаем Turbo Boost на обоих режимах для скорости компиляции
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;

        # Ограничиваем максимальную производительность на батарее до 80%
        # Это срезает самый "горячий" диапазон частот, сохраняя отзывчивость
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 80;

        # Интеллектуальное управление графикой Intel
        INTEL_GPU_MIN_FREQ_ON_AC = 300;
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_BOOST_ON_AC = 1;
        INTEL_GPU_BOOST_ON_BAT = 0; # На батарее графике буст обычно не нужен

        # Энергосбережение периферии
        PCIE_ASPM_ON_BAT = "powersave";
        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        USB_AUTOSUSPEND = 1;
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      };
  };

    # Параметры ядра
    # boot.kernelParams = [ "intel_pstate=active" "pcie_aspm=force"];

    # Полезные пакеты
    environment.systemPackages = with pkgs; [
        powertop
    ];
}
