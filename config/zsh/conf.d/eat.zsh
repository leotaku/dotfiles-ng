if [[ -n "$EAT_SHELL_INTEGRATION_DIR" ]]; then
    autoload -Uz add-zsh-hook
    BASE64_HOST="$(base64 <<< "$HOST")"

    __eat_chpwd () {
        printf '\e]51;e;A;%s;%s\e\\' "$BASE64_HOST" \
               "$(base64 <<< "$PWD")"
    }

    add-zsh-hook chpwd __eat_chpwd
fi
