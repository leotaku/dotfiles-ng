if type micromamba&>/dev/null; then
    export MAMBA_EXE="$(which micromamba)"
    export MAMBA_ROOT_PREFIX="$HOME/.local/share/micromamba"
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias micromamba="$MAMBA_EXE"
    fi
    unset __mamba_setup

    alias mamba=micromamba
fi
