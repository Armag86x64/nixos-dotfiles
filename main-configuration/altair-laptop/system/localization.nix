{ pkgs, ... }: {
  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    font = "ter-v16b"; 
    packages = [ pkgs.terminus_font ]; 
    
    # Английский по умолчанию, русский по Alt+Shift
    keyMap = "ruwin_alt_sh-UTF-8"; 
  };
}
