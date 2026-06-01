{ config, lib, unstable, ... }: {
    services.pulseaudio.enable = false;

    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    environment.systemPackages = with unstable; [
        pavucontrol
        alsa-utils
    ];
}
