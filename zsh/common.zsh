# prompt
if ! command -v starship &> /dev/null
then
    echo "'starship' could not be found. Install https://starship.rs"
fi
eval "$(starship init zsh)"
