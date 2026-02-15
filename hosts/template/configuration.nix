{ config, pkgs, inputs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ]; # Include hardware scan results.

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "REPLACE_HOST";
    networkmanager.enable = true; # Enable NetworkManager
  };

  time.timeZone = "America/Detroit";

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

  programs.zsh.enable = true;

  users.users.REPLACE_USER = {
    isNormalUser = true;
    description = "REPLACE_USER";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" "qemu" "docker" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  home-manager.users.REPLACE_USER = import ./home.nix;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "hyprland";
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true; # important for Hyprland
      theme = "sddm-sugar-dark";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  virtualisation = {
    libvirtd.enable = true;        # Enables libvirt daemon and KVM support
    docker.enable = true;        # Enable this only if you want Docker
  };

  programs.virt-manager.enable = true;

  programs.hyprland.enable = true;

  boot.kernelModules = [
    "kvm"
    "kvm-intel"
    "v4l2loopback"
  ];

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

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    docker
    xhost
    docker-compose
    gnumake42
    go
    cmake
    gcc
    gdb
    networkmanagerapplet
    pywalfox-native
    droidcam
    kdenlive
    vlc
    xcolor
    adb-sync
    wl-clipboard
    stash
    libsForQt5.qt5.qtgraphicaleffects
    linuxPackages.v4l2loopback # Kernel module for virtual webcam
    alsa-utils # Audio support
    v4l-utils # Video4Linux tools
    pipewire
    qemu
    libvirt
    virt-manager
    bridge-utils # For networking support
    dnsmasq # DHCP for VM networking
    ebtables # NAT support for VMs
    grim
    slurp
    grimblast
    swappy
    dunst
    jq
    moreutils
    hyprland
    libnotify
    coreutils
    hyprshade
    unityhub
    pkg-config
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXi
    mesa
    libGL
    alsa-lib
    (pkgs.stdenv.mkDerivation {
      pname = "sugar-candy-sddm-theme";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "MarianArlt";
        repo = "sddm-sugar-dark";
        rev = "master";
        sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
      };
      installPhase = ''
        mkdir -p $out/share/sddm/themes/sddm-sugar-dark
        cp -r * $out/share/sddm/themes/sddm-sugar-dark
      '';
    })

  ];

  # Optional: Specify the SDDM theme configuration
  # environment.etc."sddm.conf".text = lib.mkForce ''
  #   [Theme]
  #   Current=sddm-sugar-dark
  # '';
  #
  # Miscellaneous Settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System State Version
  system.stateVersion = "25.11";
}

