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
# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZSH/oh-my-zsh.sh
