export DOTFILES="$HOME/.dotfiles"

## ~~~ OH-MY-ZSH ~~~~ ##
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"

plugins=(git)

source $ZSH/oh-my-zsh.sh

## ~~~ Common ~~~
for file in $(ls -A1 $DOTFILES/zsh/*.init); do
  source $file
done

## ~~~ OS specific ~~~
case "$OSTYPE" in
  linux*)
    # nothing yet
  ;;
  darwin*)
    source $DOTFILES/zsh/homebrew.osx
  ;;
esac
