#!/bin/sh

# Update the package repository
apk update

# Install essential tools
apk add zsh curl git nano sudo openssh-keygen openssh-client figlet

# Clone Oh My Zsh repository
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Copy configuration files
cp -r .ssh/ ~/.ssh

# Install Antigen
curl -L git.io/antigen > ~/.antigen.sh

# Create an empty .dirs file
touch ~/.dirs

# Configure PATH in ~/.zshrc
echo "export PATH=\$PATH:'\$(cat ~/.dirs)'" >> ~/.zshrc

# Configure Antigen in ~/.zshrc
cat <<EOF > ~/.zshrc
# .zshrc created by brokekc0de

# ZSH env
export ZSH="$HOME/.oh-my-zsh"

# the zsh file
source $ZSH/oh-my-zsh.sh

# Antigen Configuration
source ~/.antigen.sh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Antigen Bundles
antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Apply Antigen configuration
antigen apply
EOF

echo "Setup completed!!!"

# Change the default shell to Zsh
sed -i 's:/bin/ash:/bin/zsh:' /etc/passwd

# Print "Brokenc0de Setup" using figlet
figlet "Brokenc0de Setup"
