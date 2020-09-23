#!/usr/bin/env bash

echo -e "\nInstalling Desktop\n"

PKGS=(

    # --- Setup Desktop
        'plasma'                #KDE Plasma
        'dolphin'               #File Explorer
        
    # --- Login Display Manager
        'lightdm'                   # Base Login Manager
        'lightdm-webkit2-greeter'   # Framework for Awesome Login Themes

    # --- Bluetooth
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
        'blueberry'             # Bluetooth configuration tool
        'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
    
    # --- Printers
        'cups'                  # Open source printer drivers
        'cups-pdf'              # PDF support for cups
        'ghostscript'           # PostScript interpreter
        'gsfonts'               # Adobe Postscript replacement fonts
        'hplip'                 # HP Drivers
        'system-config-printer' # Printer setup  utility

    # --- Terminal Utilities
        'curl'                  # Remote content retrieval
        'htop'                  # Process viewer
        'neofetch'              # Shows system info when you launch terminal
        'openssh'               # SSH connectivity tools
        'wget'                  # Remote content retrieval
        'zsh'                   # ZSH shell

    # --- Development
        'code'                  # Visual Studio Code
        'python'                # Scripting language

    # --- Video
    'obs-studio'            # Record your screen
    
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
echo -e "\nDone!\n"
    sudo pacman -S xorg pulseaudio pulseaudio-alsa terminator --noconfirm --needed
    sudo sed -i 's/^#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
    sudo systemctl enable lightdm
    sudo systemctl enable bluetooth
    systemctl enable org.cups.cupsd
    cd "${HOME}"
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si --noconfirm
    yay -S brave-bin pamac lightdm-webkit-theme-aether --noconfirm
    echo Setting Sudo Password
    sudo sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
    sudo sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo -e "\nReady For Reboot\n"
