export DOTFILES="$HOME/.dotfiles"

## ~~~ OH-MY-ZSH ~~~~ ##
export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions git)

source $ZSH/oh-my-zsh.sh

## ~~~ Common ~~~
source $DOTFILES/zsh/common.zsh
source $DOTFILES/zsh/go.zsh
source $DOTFILES/zsh/aliases.zsh

## ~~~ OS specific ~~~
case "$OSTYPE" in
  linux*)
    # nothing yet
  ;;
  darwin*)
    source $DOTFILES/zsh/osx.zsh
  ;;
esac
