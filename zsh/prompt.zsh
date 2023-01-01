# starship.rs
if ! command -v /opt/homebrew/bin/starship &> /dev/null
then
    echo "'starship' could not be found. Install https://starship.rs"
fi

eval "$(/opt/homebrew/bin/starship init zsh)"
