# Custom Windows 10 ISO with VirtIO Drivers

This Bash script helps you create a customized Windows 10 ISO with VirtIO drivers. This is useful for setting up Windows 10 virtual machines with better hardware support when using KVM or QEMU.

## Prerequisites

Before using this script, make sure you have the following prerequisites in place:

1. You should be running the script as the root user, or with administrator privileges, as it requires root permissions.

2. Download the official Windows 10 ISO from Microsoft's website:
   - [Download Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10)
   - Rename the downloaded ISO file to 'Win10.iso' and place it in the same folder as this script.

3. You need an internet connection, as the script will download the VirtIO drivers.

## How to Use

1. Clone or download this repository to your system.

2. Open a terminal and navigate to the directory containing the script.

3. Run the script using the following command:
   ```bash
   sudo ./custom-win10-iso.sh

4. Follow the on-screen instructions. The script will prompt you to press Enter to continue, and it will check if the 'Win10.iso' file is in the same directory or ask for the location if not found.

5. The script will automatically download the VirtIO ISO and perform the necessary steps to integrate VirtIO drivers into the Windows 10 ISO.

6. Once the process is complete, you'll find the customized ISO as 'CustomWin10.iso' in the same directory.

7. You can use 'CustomWin10.iso' to install Windows 10 in your virtual machine with better hardware support.

## Cleanup

The script will clean up temporary files and directories used during the process, so you don't need to worry about manual cleanup.

**Note:** Always make sure you have a backup of your data and important files before running this script to avoid any accidental data loss.

## Disclaimer

This script is provided as-is and without any warranty. Use it at your own risk. Be cautious while working with ISO images and ensure that you have the necessary permissions to create and modify ISO files.

## License

This script is released under the [MIT License](LICENSE).

