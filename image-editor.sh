#!/bin/bash

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as the root user. Please run it with administrator privileges."
    exit 1
fi

# Information message
echo "This script will help you create a customized Windows 10 ISO with VirtIO drivers."
echo "Make sure you have downloaded the official Windows 10 ISO from Microsoft's website:"
echo "https://www.microsoft.com/en-us/software-download/windows10"
echo "Rename the file to 'Win10.iso' and place it in the same folder as this script."
echo "Press Enter to continue or Ctrl+C to cancel."
read

# Check if the script is running in the same folder as the Windows 10 ISO
if [ -f "Win10.iso" ]; then
    ISO_PATH="./Win10.iso"
else
    read -p "Please provide the location of the downloaded Windows 10 ISO: " ISO_PATH
fi

# Check if the Windows 10 ISO exists at the provided location
if [ ! -f "$ISO_PATH" ]; then
    echo "The Windows 10 ISO was not found at the provided location."
    exit 1
fi

# Download Virtio ISO
wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso -O Virtio.iso

# Create a temporary folder
temp_dir=$(mktemp -d)
mkdir windows
mkdir drivers

# Mount the Windows 10 ISO
mount -o loop "$ISO_PATH" "$temp_dir"
cp -r "$temp_dir"/* windows/
umount "$temp_dir"

# Mount the Virtio ISO
mount -o loop Virtio.iso "$temp_dir"
cp -r "$temp_dir"/* drivers/
umount "$temp_dir"

# Modify the boot.wim file
wimmountrw windows/sources/boot.wim 1 "$temp_dir"
cp -r drivers "$temp_dir/"
wimunmount --commit "$temp_dir"
wimmountrw windows/sources/boot.wim 2 "$temp_dir"
cp -r drivers "$temp_dir/"
wimunmount --commit "$temp_dir"

# Compile the new ISO
mkisofs -allow-limited-size -o CustomWin10.iso -b boot/etfsboot.com -no-emul-boot -boot-load-seg 0x07C0 -boot-load-size 8 -iso-level 2 -J -l -D -N -joliet-long -relaxed-filenames -V "Custom Win10" -allow-lowercase

# Cleanup
rm -rf "$temp_dir" windows drivers Virtio.iso

echo "The customized ISO has been created as 'CustomWin10.iso'."
