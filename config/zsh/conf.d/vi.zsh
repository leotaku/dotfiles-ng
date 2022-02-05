KEYTIMEOUT=1

bindkey -v '^?' backward-delete-char
bindkey -v '^M' vi-accept-line
bindkey -a '^[' vi-insert

function _vi_reset_cursor() {
    printf %b "\e[6 q"
}
zle -N zle-line-init _vi_reset_cursor

function _vi_accept_line() {
    zle accept-line
    printf %b "\e[2 q"
}
zle -N vi-accept-line _vi_accept_line

function _vi_set_cursor() {
    if [[ "$KEYMAP" == "main" ]]; then
        printf %b "\e[6 q"
    else
        printf %b "\e[2 q"
    fi
}
zle -N zle-keymap-select _vi_set_cursor
