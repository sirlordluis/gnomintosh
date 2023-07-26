#!/bin/bash

user_name=$(who am i | awk '{print $1}')

if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be run as root (with sudo)."
  exit 1
fi

curl -s "https://raw.githubusercontent.com/saint-13/Linux_Dynamic_Wallpapers/main/Easy_Install.sh" | sudo bash
su "$user_name"

# Cleaning previous directories
echo "Cleaning directories..."
#rm WhiteSur* -rf &&

## Cloning required files
# GTK theme
git clone https://github.com/jothi-prasWhiteSur-gtk-theme.git --depth=1ath/
# Icons
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
# Cursors
git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1

## Installing theme ##
# GTK theme
if [[ -f "$1" || "$1" = '-light' ]]; then
  WhiteSur-gtk-theme/install.sh -l -c Light
else
  WhiteSur-gtk-theme/install.sh -l -c Dark
fi
WhiteSur-gtk-theme/tweaks.sh -F

# Icons
WhiteSur-icon-theme/install.sh -b

# Cursors
mkdir -p ~/.local/share/icons/WhiteSur-cursors
cp WhiteSur-cursors/dist/* ~/.local/share/icons/WhiteSur-cursors -prf

# Wallpapers
mkdir -p ~/Pictures/
cp -r wallpaper/* ~/Pictures/ 
gsettings set org.gnome.desktop.background picture-uri "file:///home/$user_name/Pictures/monterey.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$user_name/Pictures/monterey.png"

# Load settings using dconf
dconf load / < dconf/settings.dconf

# Fonts
cp fonts/* ~/.local/share/fonts/ 