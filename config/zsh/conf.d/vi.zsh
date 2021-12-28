# local creset="$(printf %b "$terminfo[civis]\e[6 q")"
# RPS1="${RPS1}%{$creset%}"
KEYTIMEOUT=1

bindkey -v '^?' backward-delete-char
bindkey -v '^M' vi-accept-line
bindkey -a '^[' vi-insert

function _vi_reset_cursor() {
    printf %b "\e[6 q"
    printf %b "$terminfo[cnorm]"
}
add-zsh-hook precmd _vi_reset_cursor

function vi-accept-line() {
    # printf %b "$terminfo[civis]"
    printf %b "\e[2 q"
    zle accept-line
}
zle -N vi-accept-line

function _vi_set_cursor() {
    if [[ "$KEYMAP" == "main" ]]; then
        printf %b "\e[6 q"
    else
        printf %b "\e[2 q"
    fi
}
zle -N zle-keymap-select _vi_set_cursor
