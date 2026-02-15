#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.dotfiles"

if [ ! -d "$DOTFILES" ]; then
  echo "❌ .dotfiles not found at $DOTFILES"
  exit 1
fi

echo "🔍 Detecting hostname..."
host=$(hostname)
echo "✔ Hostname detected: $host"
echo ""

read -rp "👤 Enter your username: " username
if [ -z "$username" ]; then
  echo "❌ Username cannot be empty."
  exit 1
fi

HOST_DIR="$DOTFILES/hosts/$host"

if [ -d "$HOST_DIR" ]; then
  echo "❌ Host '$host' already exists."
  exit 1
fi

echo "📁 Creating host directory..."
mkdir -p "$HOST_DIR"

echo "📋 Copying template..."
cp -r "$DOTFILES/hosts/template/"* "$HOST_DIR"

echo "✏️ Replacing placeholders..."

sed -i "s/REPLACE_HOST/$host/g" \
  "$HOST_DIR/configuration.nix"

sed -i "s/REPLACE_USER/$username/g" \
  "$HOST_DIR/configuration.nix"

sed -i "s/REPLACE_USER/$username/g" \
  "$HOST_DIR/home.nix"

echo "🖥 Generating hardware configuration..."
sudo nixos-generate-config \
  --show-hardware-config > "$HOST_DIR/hardware-configuration.nix"

echo ""
echo "🚀 Building system..."
sudo nixos-rebuild switch --flake "$DOTFILES#$host"

echo ""
echo "✅ Installation complete!"

