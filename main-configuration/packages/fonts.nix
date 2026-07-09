{ unstable, ... }: {
  environment.systemPackages = [
    unstable.nerd-fonts.caskaydia-cove
  ]; 

  fonts = {
    packages = with unstable; [
      cascadia-code
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      twemoji-color-font # Дополнительный пак, если Noto где-то забагует
    ];

    fontconfig = {
      enable = true;

      # КРИТИЧЕСКИЙ ПАРАМЕТР: Без этого Chromium видит Noto Emoji как пустые растры
      # и вместо смайликов рисует квадраты.
      useEmbeddedBitmaps = true; 

      # Настройка точного фолбека (порядка подмены)
      defaultFonts = {
        emoji     = [ "Noto Color Emoji" "Twemoji Mozilla" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        serif     = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      };
    };
  };
}
