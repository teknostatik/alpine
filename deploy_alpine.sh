#!/bin/sh

# Alpine Linux Desktop Setup Script
# ==================================
#
# This script automates the setup of a complete Alpine Linux desktop environment.
#
# What this script does:
# • Updates the system packages to the latest versions
# • Configures the desktop environment using Alpine's setup-desktop
# • Installs essential command-line tools (fastfetch, htop, git, byobu, etc.)
# • Sets up Flatpak package manager with Flathub repository access
# • Offers optional installation of common desktop applications via Flatpak
# • Integrates GNOME Software for graphical package management
#
# Applications available for installation:
# - Visual Studio Code (code editor/IDE)
# - Google Chrome (web browser)
# - Spotify (music streaming service)
#
# Prerequisites:
# • Alpine Linux system with internet connection
# • Root privileges (script must be run as root)
# • Desktop environment support (GNOME/KDE/XFCE)
#
# Usage: sudo ./deploy_alpine.sh
#
# Important Notes:
# • This script is intended to be run as root
# • You'll be prompted for each optional application
# • Flatpak applications are installed system-wide
# • The script will set up both CLI and GUI package management

# Initial setup

apk -U upgrade
setup-desktop

# Some software

apk add --no-cache \
    fastfetch \
    htop \
    git \
    byobu \
    shellcheck \
    rsync \
    curl

# Flatpak

apk add --no-cache \
    flatpak \
    gnome-software \
    gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Common applications via Flatpak

echo "Would you like to install Visual Studio Code? (code editor/IDE) (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    flatpak install -y flathub com.visualstudio.code
fi

echo "Would you like to install Google Chrome? (web browser) (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    flatpak install -y flathub com.google.Chrome
fi

echo "Would you like to install Spotify? (music streaming) (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    flatpak install -y flathub com.spotify.Client
fi

echo "Flatpak setup complete."

