function __fish_complete_nix
    commandline -pc | read -l -a cmd
    set -l without_last (commandline -opc)
    set -l cword (count $without_last)
    set -l first true

    if test (count $without_last) = (count $cmd)
        set cmd $cmd ''
    end

    NIX_GET_COMPLETIONS=$cword $cmd | while read -l line
        if test $first = true
            if test $line = "filenames"
                __fish_complete_path
            end
            set first false
        else
            echo "$line"
        end
    end
end

complete -c nix --no-files -a '(__fish_complete_nix)'
