#!/usr/bin/env bash

ISO_URL="https://blackarch.org/blackarch-linux-live-2023.12.01-x86_64.iso"
ISO_PATH="$HOME/Downloads/blackarch.iso"
VM_DISK="/var/lib/libvirt/images/blackarch.qcow2"

# Check if ISO exists, if not, download it
if [ ! -f "$ISO_PATH" ]; then
    echo "Downloading BlackArch ISO..."
    wget -O "$ISO_PATH" "$ISO_URL"
fi

# Create VM disk if it doesn’t exist
if [ ! -f "$VM_DISK" ]; then
    echo "Creating BlackArch VM disk..."
    qemu-img create -f qcow2 "$VM_DISK" 50G
fi

echo "Launching BlackArch VM..."
qemu-system-x86_64 \
    -enable-kvm \
    -m 4096 \
    -smp 4 \
    -cpu host \
    -drive file="$VM_DISK",format=qcow2 \
    -cdrom "$ISO_PATH" \
    -boot d \
    -netdev user,id=net0 -device e1000,netdev=net0 \
    -display default,show-cursor=on


ISO_URL="https://blackarch.org/blackarch-linux-live-2023.12.01-x86_64.iso"
ISO_PATH="$HOME/Downloads/blackarch.iso"
VM_DISK="/var/lib/libvirt/images/blackarch.qcow2"

# Check if ISO exists, if not, download it
if [ ! -f "$ISO_PATH" ]; then
    echo "Downloading BlackArch ISO..."
    wget -O "$ISO_PATH" "$ISO_URL"
fi

# Create VM disk if it doesn’t exist
if [ ! -f "$VM_DISK" ]; then
    echo "Creating BlackArch VM disk..."
    qemu-img create -f qcow2 "$VM_DISK" 50G
fi

echo "Launching BlackArch VM..."
qemu-system-x86_64 \
    -enable-kvm \
    -m 4096 \
    -smp 4 \
    -cpu host \
    -drive file="$VM_DISK",format=qcow2 \
    -cdrom "$ISO_PATH" \
    -boot d \
    -netdev user,id=net0 -device e1000,netdev=net0 \
    -display default,show-cursor=on


