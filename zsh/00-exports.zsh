# terminal — fall back to xterm-256color if terminfo entry is missing (e.g. xterm-ghostty over SSH)
if [[ -z "$TERM" || "$TERM" == "dumb" ]] || ! infocmp "$TERM" &>/dev/null; then
  export TERM="xterm-256color"
fi

# editor
export VISUAL=vim
export EDITOR="$VISUAL"

# language
export LANG='en_GB.UTF-8';
export LC_ALL='en_GB.UTF-8';

# paths
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
