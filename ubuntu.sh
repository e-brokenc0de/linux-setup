#!/bin/bash

# Update the package repository
sudo apt update

# Install essential tools
sudo apt -y install zsh curl git nano sudo openssh-client figlet

# Clone Oh My Zsh repository
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Optionally, copy existing SSH keys
# cp -r .ssh/ ~/.ssh

# Install Antigen
curl -L git.io/antigen > ~/.antigen.sh

# Create an empty .dirs file
touch ~/.dirs

# Configure PATH in ~/.zshrc
echo "export PATH=\$PATH:'\$(cat ~/.dirs)'" >> ~/.zshrc

# Configure Antigen in ~/.zshrc
cat <<EOF > ~/.zshrc
# .zshrc created for Ubuntu

# ZSH env
export ZSH="\$HOME/.oh-my-zsh"

# Source the zsh file
source \$ZSH/oh-my-zsh.sh

# Antigen Configuration
source ~/.antigen.sh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Antigen Bundles
antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme robbyrussell

# Apply Antigen configuration
antigen apply
EOF

echo "Setup completed!!!"

# Change the default shell to Zsh
chsh -s $(which zsh)

# Print "Setup Complete" using figlet
figlet "Setup Complete"

zsh
