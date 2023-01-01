# path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# load plugins
plugins=(
  colored-man-pages
  git
)

ZSH_CUSTOM=$DOTFILES/zsh

# load zsh
source $ZSH/oh-my-zsh.sh
