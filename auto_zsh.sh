#!/bin/bash

echo "Starting Zsh setup..."

# Install Zsh if not already installed
if ! command -v zsh &> /dev/null; then
    echo "Installing Zsh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    else
        sudo apt update && sudo apt install -y zsh
    fi
fi

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install Zsh plugins
echo "Installing plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Update .zshrc
if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
    echo "Adding plugins to .zshrc..."
    sed -i '' 's/plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /' "$HOME/.zshrc"
fi

echo "Zsh setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
