#!3/bin/bash

# This is the script that will install dwm,dmenu,st with the custom config files
# And all the pacman packages.
# Last edited: 27/02/2024 7:46 gmt -0300

current_dir = $(pwd)
USER = "arthur"


install_packages_from_file() {
    pacman -Syu  # Update package lists
    pacman -S --needed - < "$1"  # Install all packages listed in the file
}

install_WM() {

#This install dwm,dmenu,st with the custom config.def.h files for each program.

	mkdir /home/arthur/dwm
	mkdir /home/arthur/dwm/complementary

	git clone https://git.suckless.org/dwm "/home/$USER/dwm"
	git clone https://git.suckless.org/dmenu "/home/$USER/dwm/complementary"
	git clone https://git.suckless.org/st "/home/$USER/dwm/complementary"

	# This is the DWM condif.def.h
	rm "/home/$USER/dwm/config.def.h"
	mv "$current_dir/arch_build/config_files/dwm/config.def.h" "home/$USER/dwm/"
	
	# This is the DMENU config.def.h
	rm "/home/$USER/dwm/complementary/dmenu/config.def.h"
	mv "$current_dir/arch_build/config_files/dmenu/config.def.h" "/home/$USER/dwm/complementary/dmenu"

	# This is the ST config.def.h
	rm "/home/$USER/dwm/complementary/st/config.def.h"
	mv "$current_dir/arch_build//config_files/st/config.def.h" "/home/$USER/dwm/complementary/st"

	# Install dwm, dmenu and st

	cd "/home/$USER/dwm"
	make clean install
	cd "home/$USER/dwm/complementary/dmenu"
	make clean install
	cd "home/$USER/dwm/complementary/st"
	make clean install
	}

install_apps() {
	# This function installs tools such as flameshot, xbindkeys
	# Also copies .xinitrc .bash_rc .xbindkeysrc to ur home dir

	mv "/home/$USER/arch_build/config_files/.xinitrc" "/home/$USER/"
	mv "/home/$USER/arch_build/config_files/.xbindkeysrc" "/home/$USER/"
	mv "/home/$USER/arch_build/config_files/.bash_profile" "/home/$USER/"
	mv "/home/$USER/arch_build/config_files/.bash_rc" "/home/$USER"

	cd "/home/$USER"
	chmod +x .xinitrc
	}

install_packages_from_file "pkg-list.txt"

