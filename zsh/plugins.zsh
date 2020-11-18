source $HOME/.zplug/init.zsh

# theme
zplug "romkatv/powerlevel10k", as:theme, depth:1

# plugins
zplug "djui/alias-tips"
zplug "plugins/colored-man-pages",         from:oh-my-zsh
zplug "plugins/extract",                   from:oh-my-zsh
zplug "plugins/git",                       from:oh-my-zsh
zplug "plugins/history",                   from:oh-my-zsh
zplug 'zplug/zplug',                       hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-autosuggestions",     defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3, on:"zsh-users/zsh-autosuggestions"

# -----------------------------------------------------------------------------

if ! zplug check --verbose; then
   zplug install
fi

zplug load
