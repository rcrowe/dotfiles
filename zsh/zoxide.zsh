# Load Zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
else
    echo "'zoxide' could not be found. Install https://github.com/ajeetdsouza/zoxide"
fi
