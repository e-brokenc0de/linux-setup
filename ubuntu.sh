#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Install required packages
install_requirements() {
    echo "Installing required packages..."
    sudo apt update
    sudo apt install -y curl gnupg sudo lsb-release ca-certificates
}

# Ensure required packages are installed
install_requirements

# Function to install gum
install_gum() {
    echo "Installing gum..."
    if ! command_exists gum; then
        echo "gum could not be found, installing..."
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
        echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
        sudo apt update && sudo apt install gum
    fi
}

# Install gum first to ensure it's available for further commands
install_gum

# Ensure gum is available after installation
if ! command_exists gum; then
    echo "gum is required but not installed correctly. Please check the installation process and run the script again."
    exit 1
fi

# Function to install PHP and its extensions
install_php() {
    if command_exists php; then
        gum style --foreground 212 "PHP is already installed."
    else
        if gum confirm "Do you want to install PHP?"; then
            gum style --foreground 212 "Adding PHP repository..."
            sudo add-apt-repository ppa:ondrej/php -y
            sudo apt update

            gum style --bold --border-foreground 212 --border double --padding "1 2" --margin "1" "Choose PHP packages to install:"
            php_packages=$(gum choose --no-limit php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-mbstring php8.2-mysql php8.2-xml php8.2-zip)
            sudo apt install -y $php_packages
            install_composer
        fi
    fi
}

# Function to install PHP Composer
install_composer() {
    if command_exists composer; then
        gum style --foreground 212 "PHP Composer is already installed."
    else
        gum style --bold --border-foreground 212 --border double --padding "1 2" --margin "1" "Installing PHP Composer..."
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        php composer-setup.php --install-dir=/usr/local/bin --filename=composer
        php -r "unlink('composer-setup.php');"
    fi
}

# Function to configure Zsh with Antigen
configure_zsh() {
    gum style --bold --border-foreground 212 --border double --padding "1 2" --margin "1" "Choose Antigen bundles to install (default: git,zsh-users/zsh-syntax-highlighting,zsh-users/zsh-autosuggestions,zsh-users/zsh-completions):"
    antigen_bundles=$(gum choose --no-limit --selected=git,zsh-users/zsh-syntax-highlighting,zsh-users/zsh-autosuggestions,zsh-users/zsh-completions composer docker)
    gum style --foreground 212 "Selected bundles: $antigen_bundles"

    gum style --bold --border-foreground 212 --border double --padding "1 2" --margin "1" "Choose Zsh theme (default: robbyrussell):"
    zsh_theme=$(gum input --placeholder "robbyrussell")
    zsh_theme=${zsh_theme:-robbyrussell}

    gum style --foreground 212 "Updating .zshrc with selected bundles and theme..."
    cat <<EOT >> ~/.zshrc

# ZSH Configuration
export PATH=$PATH:$(cat ~/.dirs)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
source ~/.antigen.sh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles
antigen bundle $antigen_bundles

# Theme
antigen theme $zsh_theme

# Tell Antigen that you're done
antigen apply
EOT
}

# Function to install bun
install_bun() {
    if command_exists bun; then
        gum style --foreground 212 "bun is already installed."
    else
        if gum confirm "Do you want to install bun?"; then
            gum style --foreground 212 "Installing bun..."
            curl https://bun.sh/install | bash
        fi
    fi
}

# Function to install Docker
install_docker() {
    if command_exists docker; then
        gum style --foreground 212 "Docker is already installed."
    else
        if gum confirm "Do you want to install Docker?"; then
            gum style --foreground 212 "Installing Docker..."
            sudo apt-get update
            sudo apt-get install \
                ca-certificates \
                curl \
                gnupg \
                lsb-release
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo usermod -aG docker $USER
            gum style --foreground 212 "Docker installed successfully."
        fi
    fi
}

# Main script execution
install_php
configure_zsh
install_bun
install_docker
