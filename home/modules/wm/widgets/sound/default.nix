{ pkgs, ... }:
/* 
let
  eww-config-dir = pkgs.stdenv.mkDerivation {
    name = "eww-bw-config";
    src = ./.;
    dontUnpack = false;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out
      cp $src/eww.yuck $src/eww.css $src/cava.conf $out
    '';
  };

in */
{
  home.packages = [ pkgs.playerctl pkgs.wireplumber pkgs.cava ];
  /*
  programs.eww = {
    configDir = eww-config-dir;
  };
  */
}
