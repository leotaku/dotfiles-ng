# Prompt configuration

function fish_prompt
    echo -n (fish_gen_prompt)
    emit fish_prompt_done
    fish_prompt_show_cursor
end

function fish_mode_prompt
end

function fish_gen_prompt
    set prompt_status $status
    echo -en (prompt_pwd)

    switch "$prompt_status$IN_NIX_SHELL"
        case "0?*"
            set_color green --bold
        case "??*"
            set_color purple --bold
        case "0"
            set_color yellow --bold
        case "?"
            set_color red --bold
    end

    echo -en "%"(set_color normal)" "
end

function fish_prompt_execute
    fish_prompt_hide_cursor
    sh -c 'sleep 0.1 && echo -en "\033[?25h"' &
    commandline -f execute
end

function fish_prompt_hide_cursor
    echo -en "\033[?25l"
end

function fish_prompt_show_cursor
    echo -en "\033[?25h"
end

function fish_prompt_clear
    fish_prompt_hide_cursor
    clear
    commandline -f repaint
end

bind -M insert \cl fish_prompt_clear
bind -M visual \cl fish_prompt_clear
bind \cl fish_prompt_clear
