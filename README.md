Windows XP VM Setup Script
==========================

Overview
--------

This script automates the process of setting up a Windows XP virtual machine (VM) on Proxmox Virtual Environment (VE). It handles various tasks including VM creation, disk allocation, and ISO setup, providing a quick and efficient way to deploy a Windows XP VM.

Features
--------

-   Automated VM Creation: Configures a new VM with specified resources such as memory, CPU cores, and network settings.
-   ISO Configuration: Sets up the VM to boot from a specified ISO image, ideal for OS installation.
-   Disk Allocation: Allocates disk space for the VM on specified storage.
-   SCSI Configuration: Sets up a SCSI hard drive for the VM.

Prerequisites
-------------

-   A Proxmox VE installation.
-   Access to the command line of the Proxmox server.
-   An ISO file of Windows XP stored on accessible storage.
-   Sufficient privileges to create and configure VMs in Proxmox.

Usage Instructions
------------------

### 1\. Prepare the Script

Ensure the script file (`setup_vm.sh`) is placed on your Proxmox server and is executable. You can make the script executable by running:

bash

Copy code

`chmod +x setup_vm.sh`

### 2\. Script Parameters

The script accepts several parameters which need to be passed in a specific order:

-   `ISO_FILE`: The name of the ISO file (e.g., `win-xp.iso`).
-   `ISO_PATH`: The full path to the directory containing the ISO file.
-   `STORAGE_ID`: The ID of the storage on which the VM's disk will be created.
-   `VM_STORAGE`: The storage ID repeated or another if different for ISO.
-   `VM_DISK_SIZE`: The size of the VM's disk (e.g., `20G`).
-   `VM_MEMORY`: The amount of RAM for the VM in MB (e.g., `2048`).
-   `VM_CORES`: The number of CPU cores for the VM (e.g., `2`).
-   `VM_NAME`: The desired name of the VM (e.g., `windows-xp`).

### 3\. Run the Script

Execute the script by passing the required parameters. For example:

bash

Copy code

`./setup_vm.sh win-xp.iso /mnt/elements-drive/template/iso elements elements 20G 2048 2 windows-xp`

This command sets up a Windows XP VM named `windows-xp` with 2 CPU cores, 2048 MB of RAM, a 20 GB disk, and boots from the `win-xp.iso` located at `/mnt/elements-drive/template/iso`.

### 4\. Post-Setup

Once the script completes successfully, the VM will be configured with the specified parameters. You can start the VM using the Proxmox web interface or continue using CLI tools.

Troubleshooting
---------------

-   ISO File Not Found: Ensure the ISO path and filename are correct.
-   Disk Allocation Failed: Check that there is sufficient space on the specified storage.
-   SCSI Setup Failure: Verify the correct storage ID and parameters are used.

For further issues, consult the Proxmox logs or check the output of the script for specific error messages.