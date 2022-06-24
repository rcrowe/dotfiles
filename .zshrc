export DOTFILES="$HOME/.dotfiles"

## ~~~ OH-MY-ZSH ~~~ ##
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  zsh-autosuggestions
  colored-man-pages
  git
)

source $ZSH/oh-my-zsh.sh

## ~~~ Common ~~~ ##
source $DOTFILES/zsh/aliases.zsh
source $DOTFILES/zsh/common.zsh
source $DOTFILES/zsh/func.zsh
source $DOTFILES/zsh/go.zsh

## ~~~ OS specific ~~~ ##
case "$OSTYPE" in
  linux*)
    # nothing yet
  ;;
  darwin*)
    source $DOTFILES/zsh/osx.zsh
  ;;
esac
