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
    for file in $(ls -A1 $DOTFILES/zsh/*.linux); do
      source $file
    done
  ;;
  darwin*)
    for file in $(ls -A1 $DOTFILES/zsh/*.osx); do
      source $file
    done
  ;;
esac
