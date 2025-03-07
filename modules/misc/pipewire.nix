{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  home.packages = with pkgs; [
    pavucontrol  # GUI for managing audio devices
    helvum       # Patchbay for advanced routing (optional)
    easyeffects  # Effects like equalizer, noise reduction, etc. (optional)
    wpctl        # CLI tool for PipeWire control
  ];
}

