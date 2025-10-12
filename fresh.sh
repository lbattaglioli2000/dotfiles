#!/bin/sh

echo "Setting up your Mac..."

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Powerlevel10k setup
if [ -f "$DOTFILES/p10k.zsh" ]; then
  echo "Linking Powerlevel10k config..."
  ln -sf "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"
fi

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Remove any existing Neovim config and symlink the one from dotfiles
rm -rf "$HOME/.config/nvim"  
ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"

# Set up Catppuccin theme for tmux
rm -rf "$HOME/.config/tmux/plugins/catppuccin"
mkdir -p "$HOME/.config/tmux/plugins/catppuccin"
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/plugins/catppuccin/tmux"

# Link tmux config
rm -f "$HOME/.tmux.conf"  # remove any existing file or symlink
ln -s "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# Create a projects directories
mkdir $HOME/Code
mkdir $HOME/Herd

# Create Code subdirectories
mkdir $HOME/Code/laravel

# Clone Github repositories
./clone.sh

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
