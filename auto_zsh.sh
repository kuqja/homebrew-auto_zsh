#!/bin/bash

set -e

echo "Starting Zsh setup..."

# Detect OS type and install dependencies
install_zsh() {
    echo "Installing Zsh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    elif [[ -f "/etc/debian_version" ]]; then
        sudo apt update && sudo apt install -y zsh
    elif [[ -f "/etc/redhat-release" ]]; then
        sudo yum install -y zsh
    else
        echo "Unsupported OS. Please install Zsh manually."
        exit 1
    fi
}

# Backup existing .zshrc
backup_zshrc() {
    if [[ -f "$HOME/.zshrc" ]]; then
        echo "Backing up existing .zshrc..."
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh is already installed."
    fi
}

# Install plugins
install_plugins() {
    echo "Installing plugins..."
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
}

# Install Powerlevel10k
install_powerlevel10k() {
    echo "Installing Powerlevel10k..."
    git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || true
}

# Configure .zshrc
configure_zshrc() {
    echo "Configuring .zshrc..."
    {
        echo "export ZSH=\"$HOME/.oh-my-zsh\""
        echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\""
        echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
        echo "source \$ZSH/oh-my-zsh.sh"
    } >"$HOME/.zshrc"

    # Add optional aliases
    {
        echo "# Custom Aliases"
        echo "alias ll='ls -la'"
        echo "alias update='sudo apt update && sudo apt upgrade -y'"
    } >>"$HOME/.zshrc"

    # Detect and set light/dark theme mode (Linux/macOS specific)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        THEME_MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")
    else
        THEME_MODE="Light" # Default for Linux
    fi

    if [[ "$THEME_MODE" == "Dark" ]]; then
        echo "Detected dark mode. Applying a dark theme configuration..."
        sed -i'' 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    fi
}

# Restart Zsh
restart_zsh() {
    echo "Setup complete. Restarting Zsh..."
    exec zsh -l
}

# Main execution
install_zsh
backup_zshrc
install_oh_my_zsh
install_plugins
install_powerlevel10k
configure_zshrc
restart_zsh
