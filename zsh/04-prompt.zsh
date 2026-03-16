ZSH_THEME=""

# Source Powerlevel10k from the first available location
local p10k_paths=(
    "$(brew --prefix 2>/dev/null)/share/powerlevel10k/powerlevel10k.zsh-theme"
    "$HOME/.local/share/powerlevel10k/powerlevel10k.zsh-theme"
)

for p10k in "${p10k_paths[@]}"; do
    if [ -r "$p10k" ]; then
        source "$p10k"
        break
    fi
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
