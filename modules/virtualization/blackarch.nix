{ pkgs, ... }:

let
  blackarchISO = "https://blackarch.org/blackarch-linux-live-2023.12.01-x86_64.iso"; # Change URL if outdated
  vmStorage = "/var/lib/libvirt/images/blackarch.qcow2"; # Change this path if needed
in
pkgs.stdenv.mkDerivation {
  name = "blackarch-vm";
  buildInputs = [ pkgs.qemu ];

  unpackPhase = "true"; # No unpacking needed

  installPhase = ''
    echo "Creating BlackArch VM disk..."
    qemu-img create -f qcow2 ${vmStorage} 50G
    echo "BlackArch VM disk created at ${vmStorage}"
  '';

  meta.description = "BlackArch Linux VM installation";
}

