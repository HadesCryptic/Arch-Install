#!/usr/bin/env bash

	read -p "Please enter hostname:" hostname

	read -p "Please enter username:" username

echo
echo "-------------------------------------------------"
echo "-----------------Setting Locale------------------"
echo "-------------------------------------------------"
sed -i 's/^#en_IN UTF-8/en_IN UTF-8/' /etc/locale.gen
locale-gen
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

echo "-------------------------------------------------"
echo "-----------------Setting Hostname----------------"
echo "-------------------------------------------------"
echo "$hostname" >> /etc/hostname
echo "127.0.0.1     localhost
::1           localhost
127.0.1.1     $hostname.localdomain $hostname" >> /etc/hosts
echo done

echo "-------------------------------------------------"
echo "--------------Setting Root Password--------------"
echo "-------------------------------------------------"
passwd 

echo "-------------------------------------------------"
echo "------------------Setting Users------------------"
echo "-------------------------------------------------"
useradd -mG users,wheel,audio,video,optical,storage $username
passwd $username

sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

echo "--------------------------------------"
echo "----------Grub Installation-----------"
echo "--------------------------------------"
pacman -S grub efibootmgr mtools dosfstools os-prober --noconfirm --needed
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Grub 
grub-mkconfig -o /boot/grub/grub.cfg

echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager --noconfirm --needed
systemctl enable NetworkManager

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"

exit
exit
