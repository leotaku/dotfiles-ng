# if type direnv&>/dev/null; then
#     function _direnv_hook() {
#         trap -- '' SIGINT;
#         export DIRENV_LOG_FORMAT=""
#         eval "$(command direnv export zsh)";
#         psvar[1]="$DIRENV_DIR"
#         trap - SIGINT;
#     }
#     function direnv() {
#         command direnv $@
#         _direnv_hook
#     }
#     autoload -Uz add-zsh-hook
#     add-zsh-hook chpwd _direnv_hook
#     _direnv_hook
# fi

if type direnv&>/dev/null; then
    export DIRENV_LOG_FORMAT=""
    eval "$(direnv hook zsh)"
    function _direnv_color_hook() {
        psvar[1]="$DIRENV_DIR"
    }
    add-zsh-hook precmd _direnv_color_hook
fi
