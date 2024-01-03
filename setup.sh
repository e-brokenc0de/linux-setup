#!/bin/sh

# Update the package repository
apk update

# Install zsh, curl, git, oh-my-zsh, nano, sudo, openssh-keygen, openssh-client
apk add zsh curl git nano sudo openssh-keygen openssh-client

# Copy .zshrc to home directory
cp .zshrc ~/.zshrc

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install antigen
curl -L git.io/antigen > ~/.antigen.sh

# Create an empty .dirs file
touch ~/.dirs

# Add .dirs content to PATH in ~/.zshrc
echo "export PATH=\$PATH:$(cat ~/.dirs)" >> ~/.zshrc

# Add antigen config to ~/.zshrc
echo "source ~/.antigen.sh" >> ~/.zshrc

# Add antigen bundles to ~/.zshrc
echo "antigen use oh-my-zsh" >> ~/.zshrc
echo "antigen bundle git" >> ~/.zshrc
echo "antigen bundle zsh-users/zsh-syntax-highlighting" >> ~/.zshrc
echo "antigen bundle zsh-users/zsh-autosuggestions" >> ~/.zshrc
echo "antigen bundle zsh-users/zsh-completions" >> ~/.zshrc

# Copy .ssh directory to home directory
cp -r .ssh/ ~/.ssh

echo "Setup complete!!!"
