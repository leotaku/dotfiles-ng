if [[ -n "$EAT_SHELL_INTEGRATION_DIR" ]]; then
    autoload -Uz add-zsh-hook
    __EAT_BASE64_HOST="$(printf "%s" "$HOST" | base64)"

    __eat_chpwd () {
        printf '\e]51;e;A;%s;%s\e\\' "$__EAT_BASE64_HOST" \
               "$(printf "%s" "$PWD" | base64)"
    }

    add-zsh-hook chpwd __eat_chpwd
fi
