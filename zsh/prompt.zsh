# starship.rs
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
else
    echo "'starship' could not be found. Install https://starship.rs"
fi
