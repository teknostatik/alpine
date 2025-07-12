#!/bin/sh
# This script sets up an Alpine Linux desktop environment by installing necessary packages
# and configuring the system.  
# It is intended to be run as root.

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


