{ config, lib, pkgs, inputs, ... }: {
    imports =
      [
          #./home/default.nix
          ./main-configuration/system
          ./main-configuration/hardware
          ./main-configuration/networking
          ./main-configuration/packages.nix
      ];  

    time.timeZone = "Europe/Moscow";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_6_12;

    documentation.enable = false;
    documentation.nixos.enable = false;

    # services.flatpak.enable = true;

    environment.systemPackages = [
        inputs.home-manager.packages.${pkgs.system}.default
    ];

    services.udisks2.enable = true;  

    programs.niri.enable = true;

    services.envfs.enable = true;

    # 1. Включаем сервис Ollama
    /*
    services.ollama = {
      enable = true;
      # У тебя Intel i5-13420H, встроенная графика (iGPU) может помочь.
      # Если хочешь ускорение через Intel, раскомментируй строку ниже:
      # acceleration = "rocm"; # Или оставь пустой для CPU
    };

    # 2. Включаем Open WebUI (лучший интерфейс для работы с файлами)
    services.open-webui = {
      enable = true;
      # host = "0.0.0.0"; # Слушать все интерфейсы
      port = 8080;
      stateDir = "/var/lib/open-webui";
      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        # DATA_DIR = "/home/soundwave/.open-webui";
        # Отключаем регистрацию, если пользуешься только ты
        WEBUI_AUTH = "False";
      };
    };

    # 3. Разрешаем порт в фаерволе (на всякий случай)
    networking.firewall.allowedTCPPorts = [ 8080 ];

    users.users.soundwave.extraGroups = [ "open-webui" ];
    */

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    system.stateVersion = "25.11"; 
}
