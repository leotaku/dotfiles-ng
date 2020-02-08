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
#HIST_IGNORE_DUPS=1

# try (re)setting NixOS stuff as soon as possible
unset SSL_CERT_FILE
export TMPDIR="/run/user/$UID"
export USE_NIX2_COMMAND=true
HOME_VARS="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
[[ -e "$HOME_VARS" ]] && . $HOME_VARS

# manual autoloads
autoload -Uz edit-command-line
zle -N edit-command-line

# zplugin setup
declare -A ZPLGM
ZPLGM[BIN_DIR]="$(zplugin-install)"
# FIXME: does not work
ZPLGM[CACHE_DIR]="${XDG_CACHE_HOME:-$HOME/.cache/zplugin}"
ZPLGM[ZCOMPDUMP_PATH]="$ZPLGM[CACHE_DIR]/zcompdump"

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
bindkey "^H" backward-kill-word'
zplugin light hlissner/zsh-autopair
zplugin ice wait'0' lucid atload'
fast-theme $HOME/.config/zsh-sensible-theme.ini -q'
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait'0' atinit'' lucid atload'
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
add-zsh-hook -d precmd _zsh_autosuggest_start
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
zplugin ice pick'library/elf_load.zsh' multisrc'elves/me.zsh allies/dwarf.zsh allies/rogue.zsh' atload'rogue_setup; dwarf_setup; elf_setup;' lucid
zplugin load leotaku/village

# compinit
zpcompinit

# completion
zstyle ':compinstall' filename '~/.zshrc'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,comm -w"

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

# other keybindings
bindkey '^ ' edit-command-line
bindkey '^G' history-incremental-pattern-search-backward

# word deletion
bindkey '^H' backward-kill-word
autoload -Uz select-word-style
WORDCHARS='*?_-~=&;!#$%^'
select-word-style normal

# terminal
DISABLE_AUTO_TITLE=false
ZSH_THEME_TERM_TAB_TITLE_IDLE="zsh"

# application preferences
export RANGER_LOAD_DEFAULT_RC="FALSE"
export TR_AUTH="" # Allow torrench to send to clients
export FZF_DEFAULT_OPTS="--color 16,border:17 -m"

# Add custom path entries
if [ -z $__LOCAL_PATH_SOURCED ]; then
    export __LOCAL_PATH_SOURCED=1
fi

# aliases
alias urxvtx="urxvtc -e $HOME/.scripts/spawn-tmux.sh"
alias open="rifle"
alias show="lazy sxiv /dev/stdin"

alias ll="exa -l"
#alias canto="canto-curses"
#alias aria="aria2c"
alias transmission="transmission-remote-gtk"
alias transmission-cli="transmission-remote-cli"
#alias zathura="silent zathura"

alias EXIT="tmux kill-session"
alias QUIT="exit"
alias DETACH="tmux detach-client"

# config-aliases
alias diff="diff --color=auto"

# helpers
function swap() {
    [[ -z "$1" ]] || [[ -z "$2" ]] && exit 1
    mv "$1" ".tmp.$1" || exit 1
    mv "$2" "$1" || exit 1
    mv ".tmp.$1" "$2"
}

function lazy() {
    tmpfile="$(mktemp)"
    sponge > "$tmpfile"
    eval "${@} < $tmpfile"
    rm "$tmpfile"
}

function silent() {
    $@ &>/dev/null &|
}

function launch() {
    silent "${@}"
    exit
}

function noti () {
    cmd="${@}"
    out="$(eval ${cmd} &>/dev/stderr)"
    
    if [[ $? == 0 ]]; then
        notify-send "${cmd}" "Done!"
    else
        notify-send "${cmd}" "Failed!"
    fi
}

# 7s
function 7s {
    local file="$1"
    local archive_dir="${file%.*}"

    mkdir "$archive_dir" || return 1
    mv "$file" "$archive_dir" || {
        rm "$archive_dir" -r
        return 1
    }
    
    (cd "$archive_dir"
     7z x -bso0 "$file" || return 1
    ) || return 1
}

# kitty
function icat {
   kitty +kitten icat --align left $@
}

# emacs
function emacsd() {
    emacs --daemon ${@}
}
function et() {
    emacsclient -t ${@} --alternate-editor=""
}
function ea() {
    emacsclient -e nil --alternate-editor="" &&\
    silent emacsclient -c ${@}
}
function ec() {
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
alias l='(){ fuzzy-locate $@ | fzf }'
alias j=zlua-or-fzf

L_IGNORE_RE=".cache"

# locate a file with word-fuzzy matching and
# ignore files matching regrex "$L_IGNORE_RE"
function fuzzy-locate {
    local fuzzy=""
    for i in ${@}; do
        fuzzy="${fuzzy}.*${i}"
    done

    locate "" | rg -i "$fuzzy" | rg -v "$L_IGNORE_RE"
}

# try jumping to dir in zlua db, if it cannot
# be found run fuzzy-locate and prompt for file 
# selection with fzf
function zlua-or-fzf {
    if [[ -n "$@" ]]; then
        dir="$(_zlua -e ${@})"
        if [[ -z "$dir" ]]; then
            dir="$(fuzzy-locate \"$@\" | fzf)"
        fi
        cd "$dir"
        _zlua --add "$(pwd)" &|
    else
        _zlua | tail
    fi
}

# FIXME: direnv

# eval "$(direnv hook zsh)"
# _direnv_hook() {
#     direnv export zsh > $HOME/.direnv_cmd
#     . $HOME/.direnv_cmd    
# }

# autoload -Uz add-zle-hook-widget
# zle -N direnv-line-init _direnv_hook
# add-zle-hook-widget line-init direnv-line-init
# add-zsh-hook precmd _direnv_hook

# lf
lf () {
    tmp="$(mktemp)"
    export INITIALDIR="$PWD"
    command lf "$@"

    if [ -f "$HOME/.lfnodir" ]; then
        rm $HOME/.lfnodir
    else
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp"
            if [ -d "$dir" ]; then
                if [ "$dir" != "$PWD" ]; then
                    cd "$dir"
                fi
            fi
        fi
    fi
}

# currently testing

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
