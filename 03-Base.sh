#!/usr/bin/env bash

echo -e "\nInstalling Desktop\n"

PKGS=(

    # --- Setup Desktop
        'cinnamon'                # KDE Plasma
        'dolphin'               # File Explorer
        'nitrogen'              # Wallpaper Maker
        'lxappearance'          # Themes
        'picom'                 # Transparency
        'qtile'                 # Qtile
        'dmenu'                 # Dmenu
        'breeze'                # Mouse Cursors

    # --- Login Display Manager
        'sddm'                  # Login Manager

    # --- Bluetooth
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
        'blueberry'             # Bluetooth configuration tool
        
    # --- Audio
        'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
        'pulsemixer'            # Terminal Mixer
        'pulseaudio'            # Pulse Audio
        'pavucontrol'           # GUI Mixer 
    
    # --- Printers
        'cups'                  # Open source printer drivers
        'cups-pdf'              # PDF support for cups
        'ghostscript'           # PostScript interpreter
        'gsfonts'               # Adobe Postscript replacement fonts
        'hplip'                 # HP Drivers
        'system-config-printer'  # Printer setup  utility

    # --- Terminal Utilities
        'curl'                  # Remote content retrieval
        'htop'                  # Process viewer
        'neofetch'              # Shows system info when you launch terminal
        'openssh'               # SSH connectivity tools
        'wget'                  # Remote content retrieval
        'zsh'                   # ZSH shell
        'xterm'                 # Default Terminal Emulator
       

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
    sudo pacman -S xorg alacritty --noconfirm --needed
    sudo systemctl enable sddm
    sudo systemctl enable bluetooth
    sudo systemctl enable org.cups.cupsd
    cd "${HOME}"
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si --noconfirm
    yay -S brave-bin pamac --noconfirm
    echo Setting Sudo Password
    sudo sed -i 's/^vsync = true;/# vsync = true;/' /etc/xdg/picom.conf
    sudo sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
    sudo sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

echo -e "\nReady For Reboot\n"
