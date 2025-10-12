# Powerlevel10k Theme (Homebrew)
if [[ -r "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Load Powerlevel10k configuration
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi
