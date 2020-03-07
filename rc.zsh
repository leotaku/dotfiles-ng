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
HISTFILE="$HOME/.histfile"
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
  'F1'        "$terminfo[kf1]"
  'F2'        "$terminfo[kf2]"
  'F3'        "$terminfo[kf3]"
  'F4'        "$terminfo[kf4]"
  'F5'        "$terminfo[kf5]"
  'F6'        "$terminfo[kf6]"
  'F7'        "$terminfo[kf7]"
  'F8'        "$terminfo[kf8]"
  'F9'        "$terminfo[kf9]"
  'F10'       "$terminfo[kf10]"
  'F11'       "$terminfo[kf11]"
  'F12'       "$terminfo[kf12]"
  'Insert'    "$terminfo[kich1]"
  'Delete'    "$terminfo[kdch1]"
  'Home'      "$terminfo[khome]"
  'PageUp'    "$terminfo[kpp]"
  'End'       "$terminfo[kend]"
  'PageDown'  "$terminfo[knp]"
  'Up'        "$terminfo[kcuu1]"
  'Left'      "$terminfo[kcub1]"
  'Down'      "$terminfo[kcud1]"
  'Right'     "$terminfo[kcuf1]"
  'BackTab'   "$terminfo[kcbt]"
)

# manual autoloads
autoload -Uz edit-command-line
zle -N edit-command-line

# zplugin setup
declare -A ZPLGM
ZPLGM[HOME_DIR]="$HOME/.zplugin"
ZPLGM[BIN_DIR]="$ZPLGM[HOME_DIR]/bin"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache/zplugin}"
ZPLGM[ZCOMPDUMP_PATH]="$ZSH_CACHE_DIR/zcompdump"
mkdir -p "$ZPLGM[HOME_DIR]"
ln -sfn "$(zplugin-install)" "$ZPLGM[BIN_DIR]"

# zplugin module
module_path+=( "$ZPLGM[BIN_DIR]/zmodules/Src" )
zmodload zdharma/zplugin

# zplugin
source "$ZPLGM[BIN_DIR]/zplugin.zsh"

zplugin ice wait'0' lucid atload'
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
bindkey "$K[PageUp]" history-substring-search-up
bindkey "$K[PageDown]" history-substring-search-down
bindkey -M vicmd "$K[PageUp]" history-substring-search-up
bindkey -M vicmd "$K[PageDown]" history-substring-search-down
bindkey "$K[Up]" history-substring-search-up
bindkey "$K[Down]" history-substring-search-down'
zplugin light zsh-users/zsh-history-substring-search

zplugin ice wait'0' lucid atload'
bindkey "^H" backward-kill-word
AUTOPAIR_BKSPC_WIDGET=backward-delete-char'
zplugin light hlissner/zsh-autopair
zplugin ice wait'0' lucid atload'
fast-theme $HOME/.config/zsh-sensible-theme.ini -q'
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait'0' atinit'zpcompinit' lucid atload'
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
#add-zsh-hook -d precmd _zsh_autosuggest_start
_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait'0' has'z' silent pick'/dev/null' atload'
export _ZL_ADD_ONCE=1
export _ZL_MATCH_MODE=1
eval "$(z --init zsh fzf)"'
zplugin light skywind3000/z.lua
zplugin light zsh-users/zsh-completions

zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin ice as'completion'
zplugin snippet OMZ::plugins/rust/_rust
zplugin ice as'completion'
zplugin snippet OMZ::plugins/cargo/_cargo
zplugin ice as'completion'
zplugin snippet https://github.com/github/hub/blob/master/etc/hub.zsh_completion
zplugin ice as'completion'
zplugin snippet https://github.com/restic/restic/blob/master/doc/zsh-completion.zsh
zplugin ice as'completion'
zplugin snippet "$ZPLGM[BIN_DIR]/_zplugin"

PS1=""; RPS1=""
local starting_dir="$PWD"
zplugin ice pick'library/elf_load.zsh' multisrc'elves/me.zsh allies/dwarf.zsh allies/rogue.zsh' atload'dwarf_setup; rogue_setup; elf_setup;' lucid
zplugin load leotaku/village

# completion
zstyle ':compinstall' filename '~/.zshrc'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,comm -w"

# vi-mode
bindkey -v
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
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5F' nothing
bindkey '^[[1;5H' nothing
bindkey '^[[2;5~' nothing
bindkey '^[[3;5~' nothing

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
    exit
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

# kitty
function icat {
   kitty +kitten icat --align left $@
}

# emacs
function emacsd {
    emacs --daemon ${@}
}
function et {
    emacsclient -t ${@} --alternate-editor=""
}
function ea {
    emacsclient -e nil --alternate-editor="" &&\
    silent emacsclient -c ${@}
}
function ec {
    if xdo id -d -N Emacs; then
        if [[ -n "${@}" ]]; then
            emacsclient -n ${@}
        else
            xdo activate -d -N Emacs
        fi
    else
        ea ${@}
    fi
}
alias ek="emacsclient -e '(kill-emacs)'"
alias eks="emacsclient -e '(save-buffers-kill-emacs)'"

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

L_IGNORE_RE="\.cache|\.cargo|\.git"

# locate a file with word-fuzzy matching and
# ignore files matching regrex "$L_IGNORE_RE"
function fuzzy-locate {
    local fuzzy=""
    for i in ${@}; do
        fuzzy="${fuzzy}.*${i}"
    done

    locate -r "." | rg "$fuzzy" | rg -v "$L_IGNORE_RE"
}

function fuzzy-locate-file {
    local file="$(fuzzy-locate $@ | fzf)"
    echo -n "\"$file\"" | xsel -b
    echo "$file"
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

# lf
lf () {
    local tmp="$(mktemp)"
    export INITIALDIR="$PWD"
    command lf "$@"

    if [ -f "$HOME/.lfnodir" ]; then
        rm $HOME/.lfnodir
    else
        if [ -f "$tmp" ]; then
            local dir="$(cat "$tmp")"
            rm -f "$tmp"
            if [ -d "$dir" ]; then
                if [ "$dir" != "$PWD" ]; then
                    cd "$dir"
                fi
            fi
        fi
    fi
}

# direnv
function _direnv_hook {
    eval "$(command direnv export zsh)"
}
function direnv {
    command direnv $@
    _direnv_hook
}
add-zsh-hook chpwd _direnv_hook

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
