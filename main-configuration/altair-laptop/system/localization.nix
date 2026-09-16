{ pkgs, ... }: {
  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    font = "ter-v32b";
    earlySetup = true;
    packages = [ pkgs.terminus_font ]; 
    
    keyMap = "ruwin_alt_sh-UTF-8"; 

    # useXkbConfig = true; 
  };
}
