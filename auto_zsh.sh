#!/bin/bash

# Define colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

# Function to log success messages
log_success() {
  echo -e "${GREEN}[✔] $1${RESET}"
}

# Function to log error messages
log_error() {
  echo -e "${RED}[✘] $1${RESET}"
}

# Ensure script is run as non-root user
if [ "$EUID" -eq 0 ]; then
  log_error "Please run this script as a regular user, not as root."
  exit 1
fi

# Detect operating system and package manager
detect_os() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt >/dev/null; then
      OS="debian"
      PM="apt"
    elif command -v yum >/dev/null; then
      OS="rhel"
      PM="yum"
    elif command -v pacman >/dev/null; then
      OS="arch"
      PM="pacman"
    else
      log_error "Unsupported Linux distribution."
      exit 1
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    PM="brew"
  else
    log_error "Unsupported operating system."
    exit 1
  fi
}

# Install dependencies
install_dependencies() {
  log_success "Installing Zsh and dependencies..."
  case $PM in
    apt)
      sudo apt update && sudo apt install -y zsh curl git
      ;;
    yum)
      sudo yum install -y zsh curl git
      ;;
    pacman)
      sudo pacman -Syu --noconfirm zsh curl git
      ;;
    brew)
      brew install zsh curl git
      ;;
    *)
      log_error "Unsupported package manager."
      exit 1
      ;;
  esac
}

# Install Oh My Zsh
install_oh_my_zsh() {
  log_success "Installing Oh My Zsh..."
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    log_success "Oh My Zsh already installed."
  fi
}

# Install plugins
install_plugins() {
  log_success "Installing Zsh plugins..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting || true
  git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete || true

  # Optional: Powerlevel10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k || true
}

# Generate .zshrc file
generate_zshrc() {
  log_success "Generating .zshrc file..."
  cat >~/.zshrc <<EOL
# Path to Oh My Zsh
export ZSH="\$HOME/.oh-my-zsh"

# Theme setup
ZSH_THEME="robbyrussell"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "powerlevel10k/powerlevel10k" )

# Enable command auto-correction and dots for completion waiting
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins setup
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autocomplete
)

# Source Oh My Zsh
source \$ZSH/oh-my-zsh.sh

# Custom aliases
alias ll='ls -la'
alias gs='git status'
alias gc='git commit'
alias k='kubectl'
alias d='docker'
alias update='sudo apt update && sudo apt upgrade -y'
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# Set PATH for compatibility
export PATH="\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH"
EOL
}

# Change default shell to Zsh
set_default_shell() {
  log_success "Changing default shell to Zsh..."
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    log_success "Default shell changed to Zsh. Please restart your terminal."
  else
    log_success "Default shell is already Zsh."
  fi
}

# Main script execution
main() {
  detect_os
  install_dependencies
  install_oh_my_zsh
  install_plugins
  generate_zshrc
  set_default_shell
  log_success "Setup complete! Restart your terminal or run 'zsh' to start using your new shell."
}

main
