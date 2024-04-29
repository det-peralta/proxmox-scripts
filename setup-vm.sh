#!/usr/bin/env bash

function header_info {
  clear
  cat <<"EOF"
  _      _______  _____  ____ _      ______  _  _____
 | | /| / /  _/ |/ / _ \/ __ \ | /| / / __/ | |/_/ _ \
 | |/ |/ // //    / // / /_/ / |/ |/ /\ \  _>  </ ___/
 |__/|__/___/_/|_/____/\____/|__/|__/___/ /_/|_/_/
EOF
}

header_info
echo -e "\nLoading..."

# Generate a MAC address
GEN_MAC=02:$(openssl rand -hex 5 | sed 's/\(..\)/\1:/g; s/.$//')
NEXTID=$(pvesh get /cluster/nextid)

# Set VM parameters
VMID="$NEXTID"
ISO_FILE="$1"  # First command line argument for ISO file name
ISO_PATH="$2"  # Second command line argument for full ISO path
STORAGE_ID="$3"  # Confirm if your storage ID is different
VM_STORAGE="$4"
VM_DISK_SIZE="$5"
VM_MEMORY="$6"
VM_CORES="$7"
VM_NAME="$8"

# Create VM
qm create $VMID --name $VM_NAME --memory $VM_MEMORY --cores $VM_CORES --net0 virtio,bridge=vmbr0,macaddr=$GEN_MAC

# Configure VM with ISO
if [ -f "$ISO_PATH/$ISO_FILE" ]; then
  qm set $VMID --ide2 $STORAGE_ID:iso/$ISO_FILE,media=cdrom
else
  echo "ISO file does not exist at the specified path."
  exit 1
fi

# Allocate disk space for the VM
pvesm alloc $STORAGE_ID $VMID vm-$VMID-disk-0.raw $VM_DISK_SIZE
if [ $? -eq 0 ]; then
  echo "Disk allocation successful."
else
  echo "Disk allocation failed."
  exit 1
fi

# Set the SCSI hard drive for the VM
qm set $VMID --scsi0 $STORAGE_ID:$VMID/vm-$VMID-disk-0.raw
if [ $? -eq 0 ]; then
  echo "SCSI drive set successfully."
else
  echo "Failed to set SCSI drive."
  exit 1
fi

echo "Windows XP VM setup complete. VMID: $VMID"
echo "You can now start the VM and connect to perform the installation."

# Optionally start the VM
qm start $VMID
echo "VM starting..."