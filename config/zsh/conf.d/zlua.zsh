if type z&>/dev/null; then
    export _ZL_DATA='~/.local/share/zlua_db'
    export _ZL_ADD_ONCE=1
    export _ZL_MATCH_MODE=1
    export _ZL_HYPHEN=1
    eval "$(z --init zsh)"
    alias j=z
fi
