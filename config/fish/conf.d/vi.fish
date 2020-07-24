# Vi-style keybindings
set fish_key_bindings fish_vi_key_bindings

# Cursor change based on mode
function fish_vi_cursor --on-variable fish_bind_mode --on-event fish_focus_in --on-event fish_prompt_fixed
    if test $fish_bind_mode = "insert"
        echo -en "\033[6 q"
    else if test $fish_bind_mode = "default"
        echo -en "\033[2 q"
    end
end

function fish_vi_cursor_handle_preexec --on-event fish_preexec
    echo -en "\033[2 q"
end
