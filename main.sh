#!/bin/bash

cd ~
echo "Downloading needed files started"
git clone https://github.com/saint-13/Linux_Dynamic_Wallpapers.git  
cd Linux_Dynamic_Wallpapers
echo "Files downloaded"

if [[ -d /usr/share/backgrounds/Dynamic_Wallpapers ]]
then 
	sudo rm -r /usr/share/backgrounds/Dynamic_Wallpapers
	echo "Setting up"
fi

echo "Installing wallpapers..."
sudo cp -r ./Dynamic_Wallpapers/ /usr/share/backgrounds/
sudo cp ./xml/* /usr/share/gnome-background-properties/
echo "Dynamic Wallpapers has been installed!"
cd ~ 
echo "Deleting files used only for the installation process"
sudo rm -r Linux_Dynamic_Wallpapers
echo "    |"
echo "    '---> Deleted unneeded files!"
echo "Now, don't forget to set your preferred dynamic wallpaper from Settings!"

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