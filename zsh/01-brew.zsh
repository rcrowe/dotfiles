# Homebrew — detect location dynamically (macOS ARM, macOS Intel, or Linux)
if [ -f /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
elif [ -f /usr/local/bin/brew ]; then
    eval $(/usr/local/bin/brew shellenv)
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else
    return 0
fi

# zsh plugins — source from brew if available, otherwise check user-local installs
local plugin_dirs=(
    "$(brew --prefix 2>/dev/null)/share"
    "$HOME/.local/share"
)

for base in "${plugin_dirs[@]}"; do
    if [ -r "$base/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
        source "$base/zsh-autosuggestions/zsh-autosuggestions.zsh"
        break
    fi
done

for base in "${plugin_dirs[@]}"; do
    if [ -r "$base/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "$base/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        break
    fi
done
