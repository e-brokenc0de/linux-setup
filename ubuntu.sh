#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update the package repository and install essential tools
sudo apt update && sudo apt -y install zsh curl git nano sudo openssh-client figlet software-properties-common

# Clone Oh My Zsh repository if it doesn't exist
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

# Optionally, copy existing SSH keys if .ssh directory exists
# [ -d ".ssh" ] && cp -r .ssh/ ~/

# Install Antigen if not already installed
if [ ! -f "$HOME/.antigen.sh" ]; then
    curl -L git.io/antigen > ~/.antigen.sh
fi

# Create an empty .dirs file if it doesn't exist
touch ~/.dirs

# Configure PATH and Antigen in ~/.zshrc
if ! grep -q "antigen.sh" ~/.zshrc; then
    cat <<EOF >> ~/.zshrc

# ZSH Configuration
export PATH=\$PATH:\$(cat ~/.dirs)
export ZSH="\$HOME/.oh-my-zsh"
source \$ZSH/oh-my-zsh.sh
source ~/.antigen.sh

# Antigen Bundles
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen theme robbyrussell
antigen apply
EOF
fi

# Add PHP repository and install PHP 8.2 with common extensions
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt -y install php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath php8.2-json php8.2-intl

# Install the latest version of Bun
curl -fsSL https://bun.sh/install | bash

echo "Setup completed!!!"

# Change the default shell to Zsh
chsh -s $(which zsh)

# Print "Setup Complete" using figlet
figlet "Setup Complete"

# Start Zsh shell
exec zsh
