#                  ___
#   ___======____=---=)
# /T            \_--===)
# [ \ (O)   \~    \_-==)
#  \      / )J~~    \\-=)
#   \\\\___/  )JJ~~~   \)
#    \_____/JJJ~~~~    \\
#    / \  , \\J~~~~~     \\
#   (-\)\=|\\\\\\~~~~       L__
#   (\\\\)  (\\\\\)_           \==__
#    \V    \\\\\) ===_____   \\\\\\\\\\\\
#           \V)     \_) \\\\\\\\JJ\\J\)
#   +------------+      /J\\JT\\JJJJ)
#   | Fish Shell |      (JJJ| \UUU)
#   +------------+       (UU)

set fish_greeting ''

# Key bindings
bind -M default \e        'set fish_bind_mode insert'
bind -M insert  \cH       backward-kill-word
bind -M insert  \e\[1\;5D backward-word
bind -M insert  \e\[1\;5C forward-word
bind -M insert  \e\[1\;5B true
bind -M insert  \e\[1\;5A true
bind -M insert  \e\[2~ true

# Autojump setup
if type -q z
    set -x _ZL_DATA       '~/.local/share/zlua_db'
    set -x _ZL_ADD_ONCE   1
    set -x _ZL_MATCH_MODE 1
    set -x _ZL_HYPHEN     1
    source (z --init fish | psub)
    alias j z
end

# Direnv setup
if type -q direnv
    source (direnv hook fish | psub)
end

# Aliases
alias ls='ls --color=tty --group-directories-first'
alias diff='diff --color=auto'

function nix
    SHELL=fish IN_NIX_SHELL=1 command nix $argv
end
