if type direnv&>/dev/null; then
    _direnv_precmd_hook() {
        if [[ -z "$DIRENV_DIR" ]]; then
            return
        fi
        _direnv_generic_hook
    }
    _direnv_generic_hook() {
        if [[ "$_DIRENV_PWD" != "$PWD" ]]; then
            _DIRENV_PWD="$PWD"
        else
            return
        fi
        local code="$(DIRENV_LOG_FORMAT="" direnv export zsh)"
        if [[ -n "$code" ]]; then
            eval "$code"
        fi
    }

    typeset -ag precmd_functions;
    if [[ -z "${precmd_functions[(r)_direnv_hook]+1}" ]]; then
        precmd_functions=( _direnv_precmd_hook ${precmd_functions[@]} )
    fi
    typeset -ag chpwd_functions;
    if [[ -z "${chpwd_functions[(r)_direnv_hook]+1}" ]]; then
        chpwd_functions=( _direnv_generic_hook ${chpwd_functions[@]} )
    fi
fi
