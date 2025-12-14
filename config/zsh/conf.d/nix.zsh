if [[ -n "$NIX_PROFILES" ]]; then
    for profile in $=NIX_PROFILES; do
        fpath=($fpath "$profile"/share/zsh/site-functions)
    done
fi
