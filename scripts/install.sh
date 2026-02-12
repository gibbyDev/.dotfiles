# #!/usr/bin/env bash
# # install.sh - Setup Cody's Dotfiles Environment (Nix + Home Manager)
#
# set -e
# # Always cd to the parent (repo root) so all operations work from repo base directory
# cd "$(dirname "$0")/.."
#
# # Colors for prettiness
# green='\033[0;32m'
# red='\033[0;31m'
# yellow='\033[1;33m'
# normal='\033[0m'
#
# info() { echo -e "${green}[INFO]${normal} $*"; }
# warn() { echo -e "${yellow}[WARN]${normal} $*"; }
# err() { echo -e "${red}[ERROR]${normal} $*"; }
#
# ## Step 1: Check for Nix
# if ! command -v nix &> /dev/null; then
#     err "Nix is not installed! Please install Nix first: https://nixos.org/download.html"
#     exit 1
# else
#     info "Nix is installed."
# fi
#
# ## Step 2: Enable flakes (if needed)
# if ! nix --experimental-features 'nix-command flakes' flake show &> /dev/null; then
#     warn "Nix flakes may not be enabled. Ensure your Nix version supports flakes!"
#     info "Try adding experimental-features in /etc/nix/nix.conf or your user config."
#     exit 1
# else
#     info "Nix flakes are working."
# fi
#
# ## Step 3: Home Manager presence (not mandatory but recommended)
# if ! nix flake show | grep -q 'homeConfigurations'; then
#     warn "Home Manager config not detected in flake output. Ensure it's declared if you want full integration."
# fi
#
# ## Step 4: Detect host
# HOST="$(hostname)"
#
# # Step 4a: Ensure hosts/ exists
# if [[ ! -d hosts ]]; then
#     warn "No hosts/ directory detected. Creating one."
#     mkdir hosts
#     info "Created hosts/ directory."
# fi
#
# # Step 4b: Prompt for host if needed; create scaffold if host missing
# if [[ ! -d "hosts/$HOST" ]]; then
#     warn "No host config found for '$HOST' in hosts/."
#     ls -1 hosts/ || info "No hosts configured yet."
#     read -rp "Enter the host name you want to use (type exactly): " HOST
#     if [[ ! -d "hosts/$HOST" ]]; then
#         info "Scaffolding minimal host config in hosts/$HOST ..."
#         mkdir -p "hosts/$HOST"
#         # Make home.nix
#         cat > "hosts/$HOST/home.nix" << EOF
# { config, pkgs, ... }:
# {
#   home.username = "$USER";
#   home.homeDirectory = "/home/$USER";
#   programs.zsh.enable = true;
#   home.stateVersion = "24.05";
# }
# EOF
#         # Make configuration.nix
#         cat > "hosts/$HOST/configuration.nix" << EOF
# { config, pkgs, ... }:
# {
#   imports = [ ];
#   networking.hostName = "$HOST";
#   system.stateVersion = "24.05";
# }
# EOF
#         info "Scaffolded hosts/$HOST/home.nix and configuration.nix."
#         warn "You MUST now add this new host to your flake.nix under nixosConfigurations and/or homeConfigurations."
#         info "See hosts/$HOST/home.nix and configuration.nix for templates."
#     fi
# fi
# info "Using host: $HOST"
#
# ## Step 5: Run Home Manager activation
# info "Applying Nix Flake config using Home Manager..."
# nix run .#homeConfigurations."$HOST".activationPackage
#
# ## Step 6: Symlink basic shell dotfiles (optional)
# info "Symlinking .p10k.zsh (Powerlevel10k config)..."
# ln -sf "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"
#
# info "Install complete!"
# echo -e "${green}Dotfiles and system config applied for $HOST. You may wish to relogin, or reload your shell, or review configs now.${normal}"
#
# exit 0

