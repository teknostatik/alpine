#!/bin/sh

# Enhanced Alpine Linux Desktop Setup Script
# ==========================================
#
# This script creates the most comprehensive and useful Alpine Linux installation possible.
#
# What this script does:
# • Updates the system packages to the latest versions
# • Configures the desktop environment using Alpine's setup-desktop
# • Installs comprehensive development tools and environments
# • Sets up multimedia support and codecs
# • Installs essential system utilities and monitoring tools
# • Configures Docker and containerization tools
# • Sets up programming languages (Python, Node.js, Go, Rust)
# • Installs text editors and IDEs
# • Configures networking and security tools
# • Sets up Flatpak with extensive application library
# • Optimizes system performance and security
# • Configures backup and synchronization tools
# • Sets up virtualization support
#
# Prerequisites:
# • Alpine Linux system with internet connection
# • Root privileges (script must be run as root)
# • At least 4GB of available disk space
#
# Usage: sudo ./deploy_alpine_enhanced.sh
#
# Important Notes:
# • This script is intended to be run as root
# • Installation may take significant time depending on internet speed
# • Some applications require additional manual configuration

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    error "This script must be run as root"
    exit 1
fi

log "Starting Enhanced Alpine Linux Setup..."

# Update system and setup desktop
log "Updating system packages..."
apk update && apk upgrade

log "Setting up desktop environment..."
setup-desktop

# Enable community repository
log "Enabling community repository..."
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk update

# Core system utilities
log "Installing core system utilities..."
apk add --no-cache \
    bash \
    zsh \
    fish \
    fastfetch \
    neofetch \
    htop \
    btop \
    iotop \
    iftop \
    nethogs \
    glances \
    git \
    git-lfs \
    byobu \
    tmux \
    screen \
    shellcheck \
    rsync \
    rclone \
    curl \
    wget \
    aria2 \
    unzip \
    zip \
    p7zip \
    tar \
    tree \
    exa \
    bat \
    fd \
    ripgrep \
    fzf \
    nano \
    vim \
    neovim \
    emacs \
    grep \
    find \
    sed \
    awk \
    jq \
    yq \
    less \
    which \
    man-pages \
    man-pages-posix \
    openssh-client \
    openssh-server \
    ca-certificates \
    tzdata \
    sudo \
    doas

# Network and security tools
log "Installing network and security tools..."
apk add --no-cache \
    nmap \
    wireshark \
    tcpdump \
    netcat-openbsd \
    socat \
    telnet \
    traceroute \
    whois \
    dig \
    bind-tools \
    iperf3 \
    mtr \
    fail2ban \
    ufw \
    wireguard-tools \
    openvpn \
    gnupg \
    pass \
    age \
    openssl

# Development tools and compilers
log "Installing development tools..."
apk add --no-cache \
    build-base \
    gcc \
    g++ \
    make \
    cmake \
    autoconf \
    automake \
    libtool \
    pkgconfig \
    git-doc \
    git-bash-completion \
    clang \
    llvm \
    gdb \
    valgrind \
    strace \
    ltrace \
    binutils

# Programming languages and package managers
log "Installing programming language support..."

# Python ecosystem
apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    py3-virtualenv \
    py3-wheel \
    py3-setuptools \
    pipx

# Node.js ecosystem
apk add --no-cache \
    nodejs \
    npm \
    yarn

# Go
apk add --no-cache go

# Rust
apk add --no-cache \
    rust \
    cargo

# Java
apk add --no-cache \
    openjdk11 \
    openjdk11-jdk \
    maven \
    gradle

# Other languages
apk add --no-cache \
    ruby \
    ruby-dev \
    ruby-bundler \
    php \
    php-dev \
    perl \
    lua5.4 \
    lua5.4-dev

# Container and virtualization tools
log "Installing containerization and virtualization tools..."
apk add --no-cache \
    docker \
    docker-compose \
    podman \
    buildah \
    skopeo \
    qemu \
    qemu-system-x86_64 \
    qemu-img \
    libvirt \
    virt-manager

# Enable and start Docker
rc-update add docker boot
service docker start

# Database tools
log "Installing database tools..."
apk add --no-cache \
    sqlite \
    postgresql-client \
    mysql-client \
    redis

# Multimedia support
log "Installing multimedia support..."
apk add --no-cache \
    ffmpeg \
    imagemagick \
    graphicsmagick \
    gimp \
    inkscape \
    vlc \
    mpv \
    youtube-dl \
    yt-dlp \
    pulseaudio \
    alsa-utils \
    pavucontrol

# Office and productivity tools
log "Installing office and productivity tools..."
apk add --no-cache \
    libreoffice \
    evince \
    firefox \
    thunderbird \
    filezilla \
    keepassxc

# System monitoring and maintenance
log "Installing system monitoring tools..."
apk add --no-cache \
    lm-sensors \
    smartmontools \
    hdparm \
    dmidecode \
    hwinfo \
    pciutils \
    usbutils \
    lsof \
    psmisc \
    procps \
    sysstat \
    logrotate \
    cron

# Archive and backup tools
log "Installing backup and archive tools..."
apk add --no-cache \
    borg \
    restic \
    duplicity \
    rdiff-backup \
    gzip \
    bzip2 \
    xz \
    lz4 \
    zstd

# Fonts and themes
log "Installing fonts and appearance packages..."
apk add --no-cache \
    font-awesome \
    ttf-dejavu \
    ttf-liberation \
    ttf-opensans \
    font-noto \
    font-noto-emoji \
    terminus-font

# Flatpak setup
log "Setting up Flatpak..."
apk add --no-cache \
    flatpak \
    gnome-software \
    gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Function to ask for application installation
ask_install() {
    local app_name="$1"
    local app_id="$2"
    local description="$3"
    
    echo ""
    info "Would you like to install $app_name? ($description) (y/n)"
    read -r response
    if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
        log "Installing $app_name..."
        flatpak install -y flathub "$app_id"
    fi
}

# Essential applications
log "Installing essential Flatpak applications..."

ask_install "Visual Studio Code" "com.visualstudio.code" "powerful code editor and IDE"
ask_install "Brave Browser" "com.brave.Browser" "privacy-focused web browser"
ask_install "Google Chrome" "com.google.Chrome" "web browser"
ask_install "Firefox" "org.mozilla.firefox" "open-source web browser"
ask_install "Spotify" "com.spotify.Client" "music streaming service"
ask_install "Discord" "com.discordapp.Discord" "communication platform"
ask_install "Slack" "com.slack.Slack" "team communication"
ask_install "Telegram" "org.telegram.desktop" "messaging app"
ask_install "Signal" "org.signal.Signal" "secure messaging"
ask_install "WhatsApp" "io.github.mimbrero.WhatsAppDesktop" "messaging app"

# Productivity applications
ask_install "LibreOffice" "org.libreoffice.LibreOffice" "office suite"
ask_install "Thunderbird" "org.mozilla.Thunderbird" "email client"
ask_install "Obsidian" "md.obsidian.Obsidian" "note-taking and knowledge management"
ask_install "Notion" "notion-app-enhanced" "productivity workspace"
ask_install "Todoist" "com.todoist.Todoist" "task management"
ask_install "Dropbox" "com.dropbox.Client" "cloud storage"
ask_install "Nextcloud" "com.nextcloud.desktopclient.nextcloud" "self-hosted cloud"

# Development tools
ask_install "GitKraken" "com.axosoft.GitKraken" "Git GUI client"
ask_install "Postman" "com.getpostman.Postman" "API development and testing"
ask_install "Docker Desktop" "com.docker.DockerDesktop" "container management"
ask_install "Android Studio" "com.google.AndroidStudio" "Android development IDE"
ask_install "IntelliJ IDEA Community" "com.jetbrains.IntelliJ-IDEA-Community" "Java IDE"
ask_install "PyCharm Community" "com.jetbrains.PyCharm-Community" "Python IDE"

# Creative applications
ask_install "GIMP" "org.gimp.GIMP" "image editor"
ask_install "Inkscape" "org.inkscape.Inkscape" "vector graphics editor"
ask_install "Blender" "org.blender.Blender" "3D creation suite"
ask_install "Krita" "org.kde.krita" "digital painting"
ask_install "Darktable" "org.darktable.Darktable" "photography workflow"
ask_install "Audacity" "org.audacityteam.Audacity" "audio editor"
ask_install "OBS Studio" "com.obsproject.Studio" "streaming and recording"

# Media applications
ask_install "VLC" "org.videolan.VLC" "media player"
ask_install "Plex" "tv.plex.PlexDesktop" "media streaming"
ask_install "Jellyfin" "org.jellyfin.JellyfinMediaPlayer" "media server client"
ask_install "Handbrake" "fr.handbrake.ghb" "video transcoder"

# Gaming
ask_install "Steam" "com.valvesoftware.Steam" "gaming platform"
ask_install "Lutris" "net.lutris.Lutris" "gaming platform for Linux"
ask_install "RetroArch" "org.libretro.RetroArch" "retro gaming emulator"

# Utilities
ask_install "Flatseal" "com.github.tchx84.Flatseal" "Flatpak permissions manager"
ask_install "Parabolic" "org.nickvision.tubeconverter" "video downloader"
ask_install "Bitwarden" "com.bitwarden.desktop" "password manager"
ask_install "KeePassXC" "org.keepassxc.KeePassXC" "password manager"
ask_install "Transmission" "com.transmissionbt.Transmission" "BitTorrent client"
ask_install "qBittorrent" "org.qbittorrent.qBittorrent" "BitTorrent client"

# System configuration
log "Configuring system settings..."

# Add user to important groups
warning "Please add your user to the following groups manually:"
echo "  docker, wheel, audio, video, input, plugdev"
echo "  Example: usermod -aG docker,wheel,audio,video,input,plugdev USERNAME"

# Configure Git (if not already done)
echo ""
info "Would you like to configure Git globally? (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    echo "Enter your Git username:"
    read -r git_username
    echo "Enter your Git email:"
    read -r git_email
    git config --global user.name "$git_username"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
fi

# Configure SSH (if not already done)
echo ""
info "Would you like to generate an SSH key? (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    echo "Enter your email for SSH key:"
    read -r ssh_email
    su -c "ssh-keygen -t ed25519 -C '$ssh_email'" - "$SUDO_USER"
fi

# Install Oh My Zsh (optional)
echo ""
info "Would you like to install Oh My Zsh for the current user? (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    su -c 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' - "$SUDO_USER"
fi

# Install Rust tools (optional)
echo ""
info "Would you like to install additional Rust tools? (y/n)"
read -r response
if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "yes" ] || [ "$response" = "Yes" ]; then
    su -c 'cargo install exa bat ripgrep fd-find tokei gitui bottom dust' - "$SUDO_USER"
fi

# Setup firewall
log "Configuring firewall..."
ufw --force enable
ufw default deny incoming
ufw default allow outgoing

# Enable important services
log "Enabling system services..."
rc-update add sshd default
rc-update add chronyd default
rc-update add fail2ban default

# Create useful aliases and functions
log "Creating useful shell configurations..."
cat > /etc/profile.d/enhanced_aliases.sh << 'EOF'
# Enhanced aliases for productivity
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='htop'
alias cat='bat'
alias ls='exa'
alias find='fd'
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias update='apk update && apk upgrade'
alias install='apk add'
alias search='apk search'
alias info='apk info'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# Docker aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop'
alias dstart='docker start'

# Quick system info
alias sysinfo='fastfetch'
alias weather='curl wttr.in'
alias myip='curl ifconfig.me'
EOF

log "Installation completed successfully!"
echo ""
log "============================================"
log "Enhanced Alpine Linux Setup Complete!"
log "============================================"
echo ""
warning "Important next steps:"
echo "1. Reboot your system to ensure all services start properly"
echo "2. Add your user to necessary groups (see output above)"
echo "3. Configure your desktop environment preferences"
echo "4. Install additional software through Flatpak or apk as needed"
echo "5. Configure any applications you installed"
echo ""
info "Your system now includes:"
echo "• Complete development environment (Python, Node.js, Go, Rust, Java)"
echo "• Containerization tools (Docker, Podman)"
echo "• Network and security tools"
echo "• Multimedia support"
echo "• Office productivity suite"
echo "• Modern shell tools and utilities"
echo "• Extensive Flatpak application library"
echo ""
log "Enjoy your enhanced Alpine Linux system!"
