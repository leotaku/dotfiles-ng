if [[ -z "$_FASTPROMPT_LOADED" ]]; then
    autoload -Uz add-zsh-hook

    if [[ -v "$PROMPT_EOL_MARK" ]]; then
        _FASTPROMPT_PREVIOUS_PROMPT_EOL_MARK="$PROMPT_EOL_MARK"
    else
        _FASTPROMPT_PREVIOUS_PROMPT_EOL_MARK="%"
    fi
    PROMPT_EOL_MARK=''

    function _fastprompt_initial_precmd {
        PROMPT_EOL_MARK="$_FASTPROMPT_PREVIOUS_PROMPT_EOL_MARK"
        printf '\e[H'
        add-zsh-hook -d precmd _fastprompt_initial_precmd
    }
    add-zsh-hook precmd _fastprompt_initial_precmd

    function _fastprompt_show_cursor {
        printf '\e[?25h'
    }
    zle -N zle-line-init _fastprompt_show_cursor

    print -nrP "$PS1"
    printf '\e[?25l'

    export _FASTPROMPT_LOADED="true"
fi
