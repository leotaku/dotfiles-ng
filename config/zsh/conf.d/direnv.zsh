if type direnv&>/dev/null; then
    export DIRENV_LOG_FORMAT=""
    eval "$(direnv hook zsh)"
    add-zsh-hook precmd _direnv_color_hook
fi
