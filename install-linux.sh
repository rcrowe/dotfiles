#!/usr/bin/env bash
set -e

####################################
## Zsh plugins (user-local)
####################################

SHARE_DIR="$HOME/.local/share"
mkdir -p "$SHARE_DIR"

printf "Installing zsh plugins...\n"

# Powerlevel10k
if [ ! -d "$SHARE_DIR/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SHARE_DIR/powerlevel10k"
  echo "> powerlevel10k"
fi

# zsh-autosuggestions
if [ ! -d "$SHARE_DIR/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$SHARE_DIR/zsh-autosuggestions"
  echo "> zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$SHARE_DIR/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$SHARE_DIR/zsh-syntax-highlighting"
  echo "> zsh-syntax-highlighting"
fi

####################################
## Set default shell
####################################

if [ "$SHELL" != "$(which zsh)" ]; then
  printf "\nSetting zsh as default shell...\n"
  sudo chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
fi
