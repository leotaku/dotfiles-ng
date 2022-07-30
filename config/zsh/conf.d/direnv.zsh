if type direnv&>/dev/null; then
    direnv() {
        export DIRENV_DIR="-"
        command direnv "$@"
    }

    _direnv_precmd_hook() {
        if [[ -z "$DIRENV_DIR" ]]; then
            return
        elif [[ "$DIRENV_DIR" == "-$PWD" ]]; then
            return
        fi
        _direnv_generic_hook
    }
    _direnv_generic_hook() {
        local code="$(DIRENV_LOG_FORMAT="" direnv export zsh)"
        if [[ -n "$code" ]]; then
            eval "$code"
        else
            DIRENV_DIR=""
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
