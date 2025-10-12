# Add directories to the PATH and prevent to add the same directory multiple times upon shell reload.
add_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Herd PHP binaries
add_to_path "$HOME/Library/Application Support/Herd/bin"

# Herd injected PHP versions (uncomment any that exist on your system)
add_to_path "$HOME/Library/Application Support/Herd/config/php/84/bin"
add_to_path "$HOME/Library/Application Support/Herd/config/php/83/bin"
add_to_path "$HOME/Library/Application Support/Herd/config/php/82/bin"
add_to_path "$HOME/Library/Application Support/Herd/config/php/81/bin"
add_to_path "$HOME/Library/Application Support/Herd/config/php/80/bin"
add_to_path "$HOME/Library/Application Support/Herd/config/php/74/bin"

# Herd NVM config
export NVM_DIR="$HOME/Library/Application Support/Herd/config/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"

# Load dotfiles binaries
add_to_path "$DOTFILES/bin"

# Load global Composer tools
add_to_path "$HOME/.composer/vendor/bin"

# Load global Node installed binaries
add_to_path "$HOME/.node/bin"

# Use project specific binaries before global ones
add_to_path "vendor/bin"
add_to_path "node_modules/.bin"
