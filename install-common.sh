#!/usr/bin/env bash
set -e

# Shared setup for all platforms (macOS + Linux/containers).
# Called by install.sh — not meant to be run directly.

DOTFILES="$HOME/.dotfiles"

####################################
## Dotfile symlinks
####################################

dotfile_exact=(
  ".claude/settings.json"
  ".config/direnv"
  ".config/ghostty"
  ".config/mise"
  ".editorconfig"
  ".gitconfig"
  ".zshrc"
)

# from dotfiles repo to absolute path
dotfile_map=(
  ".gitignore_global::$HOME/.gitignore"
  ".p10k.zsh::$HOME/.p10k.zsh"
)

printf "Linking config files...\n"
for file in "${dotfile_exact[@]}"; do
  mkdir -p "$(dirname "$HOME/$file")"
  rm -rf "$HOME/$file"
  ln -s "$DOTFILES/$file" "$HOME/$file"
  echo "> $HOME/$file"
done

for index in "${dotfile_map[@]}"; do
  FROM="${index%%::*}"
  TO="${index##*::}"

  rm -rf "$TO"
  ln -s "$DOTFILES/$FROM" "$TO"
  echo "> $TO"
done

####################################
## Code directories
####################################

code_directories=(
  "rcrowe"
  "work"
)

printf "\nSetting up code directories...\n"
mkdir -p ~/code

for dir in "${code_directories[@]}"; do
  mkdir -p ~/code/"$dir"
  echo "> ~/code/$dir"
done

####################################
## Oh My Zsh
####################################

printf "\nInstalling Oh My Zsh...\n"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

####################################
## Mise
####################################

printf "\nInstalling mise...\n"
if ! command -v mise &> /dev/null; then
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# Retry with GitHub rate-limit awareness — aqua backend hits the GitHub API
# which rate-limits unauthenticated requests during Docker builds.
max_attempts=5
attempt=0
until mise install --cd ~/.config/mise --yes 2>&1; do
  attempt=$((attempt + 1))
  if [ "$attempt" -ge "$max_attempts" ]; then
    echo "mise install failed after $attempt attempts"
    exit 1
  fi

  # Wait until GitHub rate limit resets (or 60s if we can't determine it)
  reset=$(curl -sf https://api.github.com/rate_limit | grep -o '"reset":[0-9]*' | head -1 | cut -d: -f2)
  now=$(date +%s)
  if [ -n "$reset" ] && [ "$reset" -gt "$now" ]; then
    delay=$(( reset - now + 5 ))
  else
    delay=60
  fi
  echo "mise install failed (attempt $attempt/$max_attempts), rate limit resets in ${delay}s..."
  sleep "$delay"
done

####################################
## Amp CLI
####################################

printf "\nInstalling Amp CLI...\n"
if ! command -v amp &> /dev/null; then
  curl -fsSL https://ampcode.com/install.sh | bash
fi

####################################
## Namespace CLI
####################################

printf "\nInstalling Namespace CLI...\n"
if ! command -v nsc &> /dev/null; then
  curl -fsSL https://get.namespace.so/cloud/install.sh | sh
fi

####################################
## Devbox CLI
####################################

printf "\nInstalling Devbox CLI...\n"
if ! command -v devbox &> /dev/null; then
  curl -fsSL https://get.namespace.so/devbox/install.sh | bash || true
fi
