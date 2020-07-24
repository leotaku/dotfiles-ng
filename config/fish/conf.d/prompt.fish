# Prompt configuration

function fish_prompt
    echo -n (fish_gen_prompt)
    kill $FISH_PROMPT_PID &>/dev/null
    emit fish_prompt_fixed
    echo -en "\033[?25h"
end

function fish_gen_prompt
    set prompt_status $status
    echo -en (prompt_pwd)

    switch "$prompt_status$IN_NIX_SHELL"
        case "0?*"
            set_color blue --bold
        case "??*"
            set_color purple --bold
        case "0"
            set_color yellow --bold
        case "?"
            set_color red --bold
    end

    echo -en ">"(set_color normal)" "
end

function fish_prompt_preexec --on-event fish_preexec
    fish_prompt_hide
    fish -c 'sleep 0.1 && echo -en "\033[?25h"' &
    set -g FISH_PROMPT_PID (jobs -lp)
    disown $FISH_PROMPT_PID
end

function fish_prompt_hide
    echo -en "\033[?25l"
end

function fish_prompt_clear
    fish_prompt_hide
    clear
    commandline -f repaint
end

bind -M insert \cl fish_prompt_clear
bind -M visual \cl fish_prompt_clear
bind \cl fish_prompt_clear

function fish_mode_prompt
end
