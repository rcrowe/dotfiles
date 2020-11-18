#!/bin/sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# PKGs
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
yay_pkgs=(
    "1password"
    "base-devel"
    "dunst"
    "git"
    "i3-gaps"
    "playerctl"
    "ripgrep"
    "slack-desktop"
    "spotify"
    "ttf-fira-code"
    "vim"
)

for pkg in ${yay_pkgs[*]}; do
    yay -S --needed $pkg
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ZSH
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [[ ! -d $ZSH ]]; then
    echo "Installing OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# manage plugins
if [[ ! -d $HOME/.zplug ]]; then
    echo "Installing Zplug"
    git clone https://github.com/zplug/zplug $HOME/.zplug
    source $HOME/.zplug/init.zsh && zplug update --self
fi
