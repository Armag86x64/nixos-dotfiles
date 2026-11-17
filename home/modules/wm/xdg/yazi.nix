{ pkgs, ... }:

let
  # Зависимости для скрипта-обертки Yazi
  launcherDeps = pkgs.buildEnv {
    name = "yazi-launcher-dependencies";
    paths = with pkgs; [
      coreutils
      yazi
      gnused
      bashInteractive
    ];
  };
in
{
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    comment = "Blazing fast terminal file manager";
    exec = "${pkgs.kitty}/bin/kitty -e yazi %u";
    icon = "utilities-terminal";
    terminal = false;
    type = "Application";
    categories = [ "System" "FileTools" "FileManager" ];
    mimeType = [ "inode/directory" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "yazi.desktop" ];
    };
  };

  # Настраиваем диалоги выбора файлов (Open/Save) на Yazi
  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text = ''
      [filechooser]
      env=PATH='${launcherDeps}/bin'
      env=TERMCMD='${pkgs.kitty}/bin/kitty --title="terminal-filechooser" -e'
      cmd='${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh'
      default_dir=$HOME
      open_mode=suggested
      save_mode=last
    '';
  };
}
