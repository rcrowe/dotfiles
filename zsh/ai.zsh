# Direnv configuration
if command -v wt &> /dev/null; then
    eval "$(command wt config shell init zsh)";
else
    echo "'wt' (worktrunk) could not be found. See https://github.com/max-sixty/worktrunk"
fi
