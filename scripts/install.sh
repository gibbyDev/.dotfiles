#!/usr/bin/env bash
# install.sh - Setup Cody's Dotfiles Environment (Nix + Home Manager)

set -e

# Colors for prettiness
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
normal='\033[0m'

info() { echo -e "${green}[INFO]${normal} $*"; }
warn() { echo -e "${yellow}[WARN]${normal} $*"; }
err() { echo -e "${red}[ERROR]${normal} $*"; }

## Step 1: Check for Nix
if ! command -v nix &> /dev/null; then
    err "Nix is not installed! Please install Nix first: https://nixos.org/download.html"
    exit 1
else
    info "Nix is installed."
fi

## Step 2: Enable flakes (if needed)
if ! nix --experimental-features 'nix-command flakes' flake show &> /dev/null; then
    warn "Nix flakes may not be enabled. Ensure your Nix version supports flakes!"
    info "Try adding experimental-features in /etc/nix/nix.conf or your user config."
    exit 1
else
    info "Nix flakes are working."
fi

## Step 3: Home Manager presence (not mandatory but recommended)
if ! nix flake show | grep -q 'homeConfigurations'; then
    warn "Home Manager config not detected in flake output. Ensure it's declared if you want full integration."
fi

## Step 4: Detect host
HOST="$(hostname)"
if [[ ! -d "../hosts/$HOST" && ! -d "hosts/$HOST" ]]; then
    warn "No host config found for '$HOST' in hosts/."
    info "Available hosts:"
    ls -1 hosts/
    read -rp "Enter the host name you want to use (type exactly): " HOST
fi
info "Using host: $HOST"

## Step 5: Run Home Manager activation
info "Applying Nix Flake config using Home Manager..."
nix run .#homeConfigurations."$HOST".activationPackage

## Step 6: Symlink basic shell dotfiles (optional)
info "Symlinking .p10k.zsh (Powerlevel10k config)..."
ln -sf "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"

info "Install complete!"
echo -e "${green}Dotfiles and system config applied for $HOST. You may wish to relogin, or reload your shell, or review configs now.${normal}"

exit 0
