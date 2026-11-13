{ stable, ... }: {
  services.mpd = {
    enable = true;
    package = stable.mpd;

    musicDirectory = "/home/soundwave/Music";

    extraConfig = ''
      audio_output {
        auto_update "yes"
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';

    network.startWhenNeeded = true;
  };
}
