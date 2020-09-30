# Arch Install Tutorial (UEFI)

### Base Install

Update pacman mirrors
```bash
# reflector --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

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
Change into install directory as root
```bash
# arch-chroot /mnt
```
Set timezone & clock
```bash
# ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# hwclock --systohc
```
Set locale, in `/etc/locale.gen` uncomment desired locale, `CTRL+O` to write and `CTRL+X` to exit
```bash
# nano /etc/locale.gen
--------------------------------------------
en_US.UTF-8 UTF-8
```
Generate locale
```bash
# locale-gen
```
Set hostname
```bash
# echo hostname > /etc/hostname
```
Edit `/etc/hosts` to contain the following contents, run `# ip a` to get IPADDRESS, `CTRL+O` to write and `CTRL+X` to exit
```bash
# nano /etc/hosts
--------------------------------------------
127.0.0.1   localhost
::1         localhost
IPADDRESS   hostname.localdomain  hostname
```
Create user
```bash
# passwd
# useradd -m username
# passwd username
# usermod -aG wheel username
```
Uncomment `wheel` group, `CTRL+O` to write and `CTRL+X` to exit
```bash
# EDITOR=nano visudo
--------------------------------------------
%wheel ALL=(ALL) ALL
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
### GUI Setup

Change `--sort age` to `--sort rate` in `/etc/xdg/reflector/reflector.conf`, `CTRL+O` to write and `CTRL+X` to exit
```bash
$ sudo nano /etc/xdg/reflector/reflector.conf
--------------------------------------------
# Sort the mirrors by synchronization time (--sort).
--sort rate
```
Start & enable `reflector.service`
```bash
$ sudo systemctl start reflector.service
$ sudo systemctl enable reflector.service
```
Enable multilib repository by uncommenting the following lines in `/etc/pacman.conf`, `CTRL+O` to write and `CTRL+X` to exit
```bash
$ sudo nano /etc/pacman.conf
--------------------------------------------
[multilib]
Include = /etc/pacman.d/mirrorlist
```
Upgrade and install drivers & utils `AMD`
```bash
$ sudo pacman -Syu
$ sudo pacman -S xorg xf86_64-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
```
Upgrade and install drivers & utils `NVIDIA`
```bash
$ sudo pacman -Syu
$ sudo pacman -S xorg nvidia nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
```
Install `yay`
```bash
$ git clone https://aur.archlinux.org/yay-git.git
$ cd yay-git
$ makepkg -si
```
Gnome
```bash
$ sudo pacman -S gdm baobab cheese eog evince file-roller gedit gnome-calculator gnome-calendar gnome-clocks gnome-control-center gnome-disk-utility gnome-font-viewer gnome-menus gnome-music gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-weather mutter nautilus totem xdg-user-dirs-gtk gvfs gvfs-afc gvfs-google gvfs-mtp gvfs-nfs gvfs-smb dconf-editor gnome-sound-recorder gnome-tweaks
$ sudo systemctl enable gdm.service
```
Budgie
```bash
$ sudo pacman -S budgie-desktop gdm baobab cheese eog evince file-roller gedit gnome-calculator gnome-calendar gnome-clocks gnome-control-center gnome-disk-utility gnome-font-viewer gnome-menus gnome-music gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-weather mutter nautilus totem xdg-user-dirs-gtk gvfs gvfs-afc gvfs-google gvfs-mtp gvfs-nfs gvfs-smb dconf-editor gnome-sound-recorder gnome-tweaks
$ sudo systemctl enable gdm.service
```
Xfce
```bash
$ sudo pacman -S gdm exo garcon thunar thunar-volman tumbler xfce-appfinder xfce-panel xfce-power-manager xfce-session xfce-settings xfce-terminal xfconf xfdesktop xfwm4 xfwm4-themes mousepad orage parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-clipman-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-fsguard-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4screenshooter xfce4-taskmanager xfce4-timer-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin
$ sudo systemctl enable gdm.service
```
KDE
```bash
$ sudo pacman -S bluedevil breeze breeze-gtk kactivitymanagerd kde-gtk-config kdecoration kdeplasma-addons kinfocenter kmenuedit kscreen kscreenlocker ksysguard kwin libkscreen libksysguard milou oxygen plasma-desktop plasma-nm plasma-pa plasma-thunderbolt plasma-workspace polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager xdg-desktop-portal-kde ark dolphin dolphin-plugins dragon elisa filelight gwenview kalarm kamoso kate kbackup kcalc kcron kdf kfind kmix konsole korganizer krdc okular print-manager spectacle
$ sudo systemctl enable sddm.service
```
Install Wine, Steam, Lutris, & dependencies
```bash
$ sudo pacman -S --needed wine-staging steam lutris gamemode lib32-gamemode giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs
```
Install desired applications, my preferences
```bash
$ yay -S brave-bin bitwarden blender discord drawio-desktop firefox gimp inkscape minecraft-launcher onlyoffice-bin virtualbox virtualbox-host-modules-arch proton-bridge proton-desktop signal-desktop slack-desktop spotify torbrowser-launcher visual-studio-code-bin zoom
```
Restart
