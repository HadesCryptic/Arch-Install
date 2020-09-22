#!/usr/bin/env bash

echo "-------------------------------------------------"
echo "-------select your disk to format----------------"
echo "-------------------------------------------------"
lsblk
echo "Please enter disk: (example /dev/sda)"
read DISK
echo "--------------------------------------"
echo -e "\nFormatting disk...\n$HR"
echo "--------------------------------------"

# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:+1000M ${DISK} # partition 1 (UEFI SYS), default start block, 512MB
sgdisk -n 2:0:0     ${DISK} # partition 2 (Root), default start, remaining

# set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8300 ${DISK}

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"ROOT" ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
mkfs.ext4 -L "ROOT" "${DISK}2"

# mount target
mount -t ext4 "${DISK}2" /mnt
mkdir /mnt/boot
mount -t vfat "${DISK}1" /mnt/boot/

echo "--------------------------------------"
echo "-----Arch Install on Main Drive-------"
echo "--------------------------------------"
pacstrap /mnt base base-devel linux linux-firmware vim nano git linux-lts --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab

echo "--------------------------------------"
echo "------Now You Are In Chroot-----------"
echo "--------------------------------------"

arch-chroot /mnt
