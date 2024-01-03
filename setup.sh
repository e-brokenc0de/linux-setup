#!/bin/sh

# Install zsh, curl, git, and oh-my-zsh
apk add zsh curl git
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

echo "Zsh setup with an empty .dirs file complete!"
