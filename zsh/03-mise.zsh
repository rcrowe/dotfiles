# Load Mise
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
else
    echo "'mise' could not be found. Install https://mise.jdx.dev"
fi
