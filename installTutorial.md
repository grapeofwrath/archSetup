# Base Install

Update system clock
```bash
# timedatectl set-ntp true
```
Create GPT partition table
```bash
# fdisk -l
# fdisk /dev/<install drive>
:g
```
Add boot partition
```bash
:n
:default
:default
:+800M
:t
:1
:1
```
Add swap partition
```bash
:n
:2
:default
:+16G(swap size)
:t
:2
:19
```
Add root partition
```bash
:n
:3
:default
:default
```
View & write partition table
```bash
:p
:w
```
Format partitions
```bash
# mkfs.fat -F32 /dev/<boot partition>
# mkswap /dev/<swap partition>
# swapon
# mkfs.ext4 /dev/<root partition>
```
Mount root partition
```bash
# mount /dev/sda3 /mnt
```
Base install
```bash
# pacstrap /mnt base base-devel linux linux-firmware nano sudo
```
Generate filesystem table
```bash
# genfstab -U /mnt >> /mnt/etc/fstab
```
Change into install root
```bash
# arch-chroot /mnt
```
Set timezone & clock
```bash
# ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# hwclock --systohc
```
Set locale
```bash
# nano /etc/locale.gen
uncomment en_US.UTF-8 UTF-8
CTRL+O
CTRL+X
# locale-gen
```
Set hostname
```bash
# echo hostname > /etc/hostname
```

```bash
# ip a
# nano /etc/hosts
127.0.0.1   localhost
::1         localhost
IPADDRESS   hostname.localdomain  hostname
CTRL+O
CTRL+X
```
Create user
```bash
# passwd
# useradd -m username
# passwd username
# usermod -aG wheel username
# EDITOR=nano visudo
uncomment %wheel ALL=(ALL) ALL
CTRL+O
CTRL+X
```
Install & setup grub
```bash
# pacman -S grub os-prober efibootmgr dosfstools mtools
# mkdir /boot/EFI
# mount /dev/<boot partition> /boot/EFI
# grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
# grub-mkconfig -o /boot/grub/grub.cfg
```
Install Network Manager & git
```bash
# pacman -S networkmanager git
# systemctl enable NetworkManager
```
Exit chroot and reboot
```bash
# exit
# umount -l /mnt
# reboot
```
