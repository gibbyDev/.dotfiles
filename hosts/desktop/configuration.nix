{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];  # Include hardware scan results.

  # Bootloader Configuration
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # System Settings
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;  # Enable NetworkManager
  };

  time.timeZone = "America/Detroit";

  boot.extraModulePackages = [
    pkgs.linuxPackages.v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="DroidCam" exclusive_caps=1
  '';

  virtualisation.docker.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # User Configuration
  users.users.cody = {
    isNormalUser = true;
    description = "cody";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" "qemu" "docker" ];
    packages = with pkgs; [];
  };

  # Display & Audio Configuration
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.sddm = {
      enable = true;
      theme = "Corners";  # Set SDDM Corners theme
    };

    desktopManager.plasma6.enable = false; # Ensure Plasma doesn't interfere with Hyprland

    # PipeWire audio setup
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Hyprland Window Manager
  programs.hyprland.enable = true;

  # Virtualization (KVM/QEMU)
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
  };

  boot.kernelModules = [
    "kvm" 
    "kvm-intel"
    "v4l2loopback"
  ]; 

  # Fonts Configuration
  fonts = {
    fontconfig.enable = true;
    fontconfig.defaultFonts.monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
    packages = with pkgs; [
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
      nerd-fonts.agave
      font-awesome
      powerline-fonts
      powerline-symbols
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cmake
    gcc
    gdb
    networkmanagerapplet
    pywalfox-native
    droidcam
    android-tools
    adb-sync
    linuxPackages.v4l2loopback  # Kernel module for virtual webcam
    alsa-utils  # Audio support
    v4l-utils   # Video4Linux tools
    pipewire
    qemu
    libvirt
    virt-manager
    bridge-utils  # For networking support
    dnsmasq       # DHCP for VM networking
    ebtables      # NAT support for VMs
    catppuccin-sddm-corners  # SDDM Corners theme
  ];

  # Miscellaneous Settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System State Version
  system.stateVersion = "24.11";
}

