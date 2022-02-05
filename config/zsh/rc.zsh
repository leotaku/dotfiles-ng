export HISTFILE="$HOME/.local/share/zsh_history"
export DUMPFILE="$HOME/.local/share/zsh_zcompdump"
export HISTSIZE=100000
export SAVEHIST=100000
setopt incappendhistory appendhistory histignorealldups histignorespace

setopt interactivecomments
setopt autocd autopushd pushdignoredups pushdminus pushdsilent
unsetopt banghist beep nomatch
autoload -Uz select-word-style
WORDCHARS='*?_~=&;!$%^:'
select-word-style normal

setopt extendedglob promptsubst
PS1='${${PWD/$HOME/~}//(#b)([^\/.])[^\/]#\//$match[1]/}%B%(?.%F{yellow}.%F{red})%(1V.%F{green}.)%%%f%b '
RPS1=''

zmodload zsh/complist
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;35:*.au=01;35:*.flac=01;35:*.m4a=01;35:*.mid=01;35:*.midi=01;35:*.mka=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.ra=01;35:*.wav=01;35:*.oga=01;35:*.opus=01;35:*.spx=01;35:*.xspf=01;35:"

function ignore { : }
zle -N ignore

zmodload zsh/terminfo
typeset -gA K=(
    'Up'          "$terminfo[kcuu1]"
    'Down'        "$terminfo[kcud1]"
    'Right'       "$terminfo[kcuf1]"
    'Left'        "$terminfo[kcub1]"
    'Home'        "$terminfo[khome]"
    'Insert'      "$terminfo[kich1]"
    'Delete'      "$terminfo[kdch1]"
    'End'         "$terminfo[kend]"
    'PageDown'    "$terminfo[knp]"
    'PageUp'      "$terminfo[kpp]"
    'C-Right'     "^[[1;5C"
    'C-Left'      "^[[1;5D"
    'C-Up'        "^[[1;5A"
    'C-Down'      "^[[1;5B"
    'C-Home'      "^[[1;5H"
    'C-End'       "^[[1;5F"
    'C-Insert'    "^[[2;5~"
    'C-Delete'    "^[[3;5~"
    'Backspace'   "^?"
    'C-Backspace' "^H"
)

# Function keys
for f in {1..12}; do
    K[F$f]="$terminfo[kf$f]"
done

bindkey -v
bindkey "$K[Up]" up-line-or-search
bindkey "$K[Down]" down-line-or-search
bindkey "$K[PageUp]" ignore
bindkey "$K[PageDown]" ignore
bindkey "$K[C-Right]" emacs-forward-word
bindkey "$K[C-Left]" emacs-backward-word
bindkey "$K[C-Up]" ignore
bindkey "$K[C-Down]" ignore
bindkey "$K[C-Home]" ignore
bindkey "$K[C-End]" ignore
bindkey "$K[C-Insert]" ignore
bindkey "$K[C-Delete]" ignore
bindkey "$K[C-Backspace]" backward-delete-word

bindkey "$K[Home]" beginning-of-line
bindkey "$K[Insert]" ignore
bindkey "$K[Delete]" delete-char
bindkey "$K[End]" end-of-line

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zcompcache"

autoload -Uz compinit
autoload -Uz bashcompinit && bashcompinit
compinit -d "$DUMPFILE"
complete -o nospace -C "/usr/bin/env terraform" terraform

# Aliases
alias ls='LC_COLLATE=C ls --color=tty --group-directories-first'
alias diff='diff --color=auto'
alias nix="SHELL=zsh command nix"

plug() {
    local zconf="${ZDOTDIR:-$HOME}/conf.d"
    local zcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    local name="$1"
    if [[ -f "$zconf/$name" ]]; then
        source "$zconf/$name"
    else
        if [[ ! -d "$zcache/$name" ]]; then
            mkdir -p "$zcache"
            git clone git@github.com:zsh-users/"$name".git "$zcache/$name"
        fi
        source "$zcache/$name/$name.plugin.zsh"
    fi
}

plug nix.zsh
plug vi.zsh
plug direnv.zsh
plug zlua.zsh

bindkey "$K[Up]"   history-substring-search-up
bindkey "$K[Down]" history-substring-search-down

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,standout"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,standout"

plug zsh-autosuggestions
plug zsh-history-substring-search
plug zsh-completions
