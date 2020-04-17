#    ____  _____/ /_  __________
#   /_  / / ___/ __ \/ ___/ ___/
#  _ / /_(__  ) / / / /  / /__
# (_)___/____/_/ /_/_/   \___/
#
# simple zsh config with cool prompt

# profiler
zmodload zsh/zprof

# basic options
setopt autocd extendedglob
setopt interactivecomments
setopt sharehistory
unsetopt beep
histchars=#

# basic settings
ZDOTDIR="${ZDOTDIR:-$HOME}"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
HISTFILE="${ZDOTDIR}/.histfile"
HISTSIZE=100000
SAVEHIST=100000
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

# try (re)setting NixOS stuff as soon as possible
unset SSL_CERT_FILE
export USE_NIX2_COMMAND=true
HM_VARS_FILE="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
[[ -e "$HOME_VARS" ]] && . $HM_VARS_FILE

# vi-mode pre setup
bindkey -v

# terminfo/reliable mappings
zmodload zsh/terminfo
typeset -gA K=(
    'F7'        "^[[18~"
    'Home'      "^[[1~"
    'Insert'    "^[[2~"
    'Delete'    "^[[3~"
    'End'       "^[[4~"
    'PageUp'    "^[[5~"
    'PageDown'  "^[[6~"
    'Up'        "^[[A"
    'Left'      "^[[D"
    'Down'      "^[[B"
    'Right'     "^[[C"
    'BackTab'   "^[[Z"
    'C-Right'   "^[[1;5C"
    'C-Left'    "^[[1;5D"
)

# manual autoloads
autoload -Uz edit-command-line
zle -N edit-command-line

# zinit setup
declare -A ZINIT
ZINIT[HOME_DIR]="${XDG_DATA_HOME:-$HOME/.local/share}/zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
ZINIT[ZCOMPDUMP_PATH]="$ZSH_CACHE_DIR/zcompdump"
mkdir -p "$ZINIT[HOME_DIR]"
ln -sfn "$(zplugin-install)" "$ZINIT[BIN_DIR]"

# zinit module
module_path+=( "$ZINIT[BIN_DIR]/zmodules/Src" )
zmodload zdharma/zplugin

# zinit load
source "$ZINIT[BIN_DIR]/zinit.zsh"

zinit ice wait'0' lucid atload'
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
bindkey "$K[Up]" history-substring-search-up
bindkey "$K[Down]" history-substring-search-down'
zinit load zsh-users/zsh-history-substring-search

zinit ice lucid atload'
bindkey "^H" backward-kill-word
AUTOPAIR_BKSPC_WIDGET=backward-delete-char'
zinit load hlissner/zsh-autopair

zinit ice wait'0' lucid atload'
fast-theme $HOME/.config/zsh-sensible-theme.ini -q'
zinit load zdharma/fast-syntax-highlighting

zinit ice wait'0' atinit'zpcompinit' lucid atload'
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

zinit ice wait'0' has'z' lucid pick'/dev/null' atload'
export _ZL_DATA="${ZDOTDIR}/.zlua"
export _ZL_ADD_ONCE=1
export _ZL_MATCH_MODE=1
eval "$(z --init zsh fzf)"'
zinit load skywind3000/z.lua

zinit ice wait'0' has'direnv' lucid pick'/dev/null' atload'
function _direnv_hook {
    eval "$(command direnv export zsh)"
}
function direnv {
    command direnv $@
    _direnv_hook
}
add-zsh-hook chpwd _direnv_hook'
zinit load direnv/direnv

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice as'completion'
zinit snippet OMZ::plugins/rust/_rust
zinit ice as'completion'
zinit snippet OMZ::plugins/cargo/_cargo
zinit ice as'completion'
zinit snippet https://github.com/github/hub/blob/master/etc/hub.zsh_completion
zinit ice as'completion'
zinit snippet https://github.com/restic/restic/blob/master/doc/zsh-completion.zsh
zinit ice as'completion'
zinit snippet "$ZINIT[BIN_DIR]/_zinit"

PS1="%~> "; RPS1=""
local starting_dir="$PWD"
zinit ice atinit'VILLAGE=(reference dwarf rogue)' lucid
zinit load leotaku/village

# completion
zstyle ':compinstall' filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR"
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,comm -w"

# vi-mode
bindkey -M vicmd "$K[Home]" beginning-of-line
bindkey -M vicmd "$K[End]" vi-end-of-line
bindkey "$K[Home]" beginning-of-line
bindkey "$K[End]" vi-end-of-line
export KEYTIMEOUT=4

# theist-mode integration
bindkey "$K[F7]" vi-cmd-mode
bindkey -M vicmd "$K[F7]" vi-insert
bindkey "^[" vi-cmd-mode
bindkey -M vicmd "^[" vi-insert

# empty function and widget
function nothing { : }
zle -N nothing

# better defaults
bindkey "$K[Delete]" delete-char
bindkey "$K[Insert]" nothing
bindkey "$K[PageUp]" nothing
bindkey "$K[PageDown]" nothing
bindkey "$K[BackTab]" nothing
bindkey "$K[C-Right]" emacs-forward-word
bindkey "$K[C-Left]" emacs-backward-word
bindkey "^[[1;5F" nothing
bindkey "^[[1;5H" nothing
bindkey "^[[2;5~" nothing
bindkey "^[[3;5~" nothing

# word deletion
bindkey '^H' backward-kill-word
autoload -Uz select-word-style
WORDCHARS='*?_-~=&;!#$%^:'
select-word-style normal

# other keybindings
bindkey '^ ' edit-command-line
bindkey '^G' history-incremental-pattern-search-backward

# application preferences
export LS_COLORS
export GIT_ASKPASS=""
export FZF_DEFAULT_OPTS="--color 16,border:17 -m"

# Add custom path entries
if [ -z $__LOCAL_PATH_SOURCED ]; then
    export __LOCAL_PATH_SOURCED=1
fi

# aliases
alias ll="exa -l"
alias show="lazy sxiv /dev/stdin"
alias transmission="transmission-remote-gtk"
alias transmission-cli="transmission-remote-cli"

# config-aliases
alias ls="ls --color=auto"
alias diff="diff --color=auto"

# helper functions
function swap {
    [[ -z "$1" ]] || [[ -z "$2" ]] && exit 1
    mv "$1" ".tmp.$1" || exit 1
    mv "$2" "$1" || exit 1
    mv ".tmp.$1" "$2"
}

function lazy {
    tmpfile="$(mktemp)"
    sponge > "$tmpfile"
    eval "${@} < $tmpfile"
    rm "$tmpfile"
}

function silent {
    $@ &>/dev/null &|
}

function launch {
    silent "${@}"
    xdo close
}

function noti {
    cmd="${@}"
    out="$(eval ${cmd} &>/dev/stderr)"

    if [[ $? == 0 ]]; then
        notify-send "${cmd}" "Done!"
    else
        notify-send "${cmd}" "Failed!"
    fi
}

# emacs
function ec {
    emacsclient --alternate-editor="systemctl --user status emacs.service" -n -c ${@}
}
function ek {
    systemctl --user restart emacs.service
}
function eks {
    emacsclient -e '(save-buffers-kill-emacs)' && systemctl --user restart emacs.service
}

# easydirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# zlua + locate
alias l=fuzzy-locate-file
alias j=zlua-or-fzf

FUZZY_LOCATE_IGNORE="\.cache|\.cargo|\.git"

# locate a file with word-fuzzy matching and
# ignore files matching regrex "$L_IGNORE_RE"
function fuzzy-locate {
    local fuzzy=""
    for i in ${@}; do
        fuzzy="${fuzzy}.*${i}"
    done

    locate -r "." | rg "$fuzzy" | rg -v "$FUZZY_LOCATE_IGNORE"
}

function fuzzy-locate-file {
    local file="$(fuzzy-locate $@ | fzf)"
    if [[ -n "$file" ]]; then
        echo -n "\"$file\"" | xsel -b
        echo "$file"
    fi
}

# try jumping to dir in zlua db, if it cannot
# be found run fuzzy-locate and prompt for file
# selection with fzf
function zlua-or-fzf {
    if [[ -n "$@" ]]; then
        local dir="$(_zlua -e ${@})"
        if [[ -z "$dir" ]]; then
            dir="$(fuzzy-locate | fzf)"
        fi
        cd "$dir"
        _zlua --add "$(pwd)" &|
    else
        _zlua | tail
    fi
}

# experimental
function nm {
    if [[ -z "$@" ]]; then
        notmuch search tag:unread
        notmuch tag -unread tag:unread
    else
        notmuch $@
    fi
}

function zsudo {
    sudo zsh -c "$functions[$1]" "$@"
}

function nix-shell {
    command nix-shell --run "exec zsh" $@
}

function nix {
    if [[ "$1" == "run" ]] && ! [[ ${@[(ie)-c]} -le ${#@} ]]; then
        shift
        command nix run $@ -c exec zsh
    else
        command nix $@
    fi
}

# profile startup
# zprof | head
