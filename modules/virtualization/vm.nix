{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    virt-manager
    virt-viewer
    dnsmasq
    bridge-utils
    ebtables
    iptables
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
  };

  users.groups.libvirtd.members = [ "cody" ]; # Replace "cody" with your username

  systemd.services.libvirtd.wantedBy = [ "multi-user.target" ];

  networking.firewall.allowedTCPPorts = [ 5900 ]; # VNC for VM access

  services.udev.packages = [ pkgs.qemu_kvm ];

  nixpkgs.config.allowUnfree = true;
}

