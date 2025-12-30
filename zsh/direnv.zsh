# Direnv configuration
if command -v direnv &> /dev/null; then
    export DIRENV_LOG_FORMAT="$(printf "\033[2mdirenv: %%s\033[0m")"
    eval "$(direnv hook zsh)"
    _direnv_hook() {
        eval "$(direnv export zsh 2> >(egrep -v -e '^....direnv: export' >&2))"
    };
else
    echo "'direnv' could not be found. Install https://direnv.net"
fi
