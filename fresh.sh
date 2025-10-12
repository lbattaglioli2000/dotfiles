
#!/bin/sh
# ---------------------------------------------------------------------
#  macOS Bootstrap Script
#  Purpose: Automate initial system setup, install core tools,
#           and link dotfiles for a consistent dev environment.
# ---------------------------------------------------------------------

echo "🔧 Setting up your Mac..."

# ---------------------------------------------------------------------
# 1. Install Xcode Command Line Tools
# ---------------------------------------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "✅ Xcode Command Line Tools already installed."
fi

# ---------------------------------------------------------------------
# 2. Install Oh My Zsh (if missing)
# ---------------------------------------------------------------------
if ! command -v omz &>/dev/null; then
  echo "📦 Installing Oh My Zsh..."
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# ---------------------------------------------------------------------
# 3. Install Homebrew (if missing)
# ---------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

# ---------------------------------------------------------------------
# 4. Symlink Zsh Configuration
# ---------------------------------------------------------------------
echo "🔗 Linking .zshrc..."
rm -f "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"

# ---------------------------------------------------------------------
# 5. Install Brew Packages (Brewfile)
# ---------------------------------------------------------------------
echo "🍺 Installing Homebrew packages..."
brew update
brew tap homebrew/bundle
brew bundle --file "$HOME/.dotfiles/Brewfile"

# ---------------------------------------------------------------------
# 6. Powerlevel10k Setup
# ---------------------------------------------------------------------
if [ -f "$DOTFILES/p10k.zsh" ]; then
  echo "🎨 Linking Powerlevel10k config..."
  ln -sf "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"
fi

# ---------------------------------------------------------------------
# 7. Neovim Configuration
# ---------------------------------------------------------------------
echo "🔗 Linking Neovim config..."
rm -rf "$HOME/.config/nvim"
ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"

# ---------------------------------------------------------------------
# 8. Tmux Setup
# ---------------------------------------------------------------------
echo "🔧 Setting up tmux..."

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "📦 Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install Catppuccin theme
echo "🎨 Setting up Catppuccin tmux theme..."
rm -rf "$HOME/.config/tmux/plugins/catppuccin"
mkdir -p "$HOME/.config/tmux/plugins"
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git \
  "$HOME/.config/tmux/plugins/catppuccin"

# Link tmux config
rm -f "$HOME/.tmux.conf"
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# ---------------------------------------------------------------------
# 9. Create Default Directories
# ---------------------------------------------------------------------
echo "📁 Creating project directories..."
mkdir -p "$HOME/Code/laravel" "$HOME/Herd"

# ---------------------------------------------------------------------
# 10. Clone GitHub Repositories
# ---------------------------------------------------------------------
if [ -f "./clone.sh" ]; then
  echo "🐙 Cloning GitHub repositories..."
  ./clone.sh
fi

# ---------------------------------------------------------------------
# 11. Apply macOS Preferences
# ---------------------------------------------------------------------
if [ -f "./.macos" ]; then
  echo "🧭 Applying macOS preferences..."
  source "./.macos"
fi

echo "✅ Setup complete! Open a new terminal to start fresh."
