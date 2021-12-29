if type direnv&>/dev/null; then
    export DIRENV_LOG_FORMAT=""
    eval "$(direnv hook zsh)"
    function _direnv_color_hook() {
        psvar[1]="$DIRENV_DIR"
    }
    add-zsh-hook precmd _direnv_color_hook
fi
