autoload -Uz add-zsh-hook

function _nix() {
    local ifs_bk="$IFS"
    local input=("${(Q)words[@]}")
    IFS=$'\n'
    local res=($(NIX_GET_COMPLETIONS=$((CURRENT - 1)) "$input[@]"))
    IFS="$ifs_bk"
    local tpe="${${res[1]}%%>	*}"
    local -a suggestions
    declare -a suggestions
    for suggestion in ${res:1}; do
        suggestions+="${suggestion/	/:}"
    done
    if [[ "$tpe" == filenames ]]; then
        compadd -f
    fi

    _describe 'nix' suggestions
}

function _nix_color_hook() {
    psvar[1]="$IN_NIX_SHELL"
}
add-zsh-hook precmd _nix_color_hook

compdef _nix nix
