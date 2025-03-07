{ config, lib, pkgs, ... }:

{
  # Enable PipeWire
#  services.pipewire = {
#    enable = true;
#    audio.enable = true;
#    alsa = {
#      enable = true;
#      support32Bit = true;
#    };
#    pulse.enable = true;
#    jack.enable = true;
#  };

  # Enable real-time scheduling for better audio performance
#  security.rtkit.enable = true;

  # Disable PulseAudio (ensure it's removed if previously enabled)
#  hardware.pulseaudio.enable = false;

  # Optional: Install `pavucontrol` for a GUI to manage audio
  home.packages = with pkgs; [
    pavucontrol
    helvum  # For managing audio routing visually
    qpwgraph # Graph-based PipeWire manager
  ];
}

