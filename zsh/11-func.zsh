extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  tar xvfJ $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

setup-machine() {
    # Atuin - shell history sync
    if command -v atuin &> /dev/null; then
        if atuin status 2>/dev/null | grep -q "Username:"; then
            printf "✓ atuin: already authenticated and syncing\n"
        else
            printf "→ atuin: logging in as nobby.crowe@gmail.com\n"
            atuin login -u nobby.crowe@gmail.com
            printf "→ atuin: syncing history\n"
            atuin sync
            printf "✓ atuin: setup complete\n"
        fi
    else
        printf "✗ atuin: not installed (expected via mise)\n"
    fi
}

update() {
    # Homebrew
    if command -v brew &> /dev/null; then
        brew update && brew upgrade && brew cleanup
    fi

    # Amp
    if command -v amp &> /dev/null; then
        amp update
    fi

    # Namespace
    if command -v nsc &> /dev/null; then
        nsc version update
    fi
    if command -v devbox &> /dev/null; then
        devbox update
    fi

    # Mise
    if command -v mise &> /dev/null; then
        mise self-update
        mise up --cd ~/.config/mise
        mise prune --cd ~/.config/mise
    fi

    # Oh-My-Zsh
    if command -v omz &> /dev/null; then
        omz update
    fi
}
