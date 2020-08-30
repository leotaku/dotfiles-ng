# Commands

stow: config desktop home systemd

config:  (link "config"  "$HOME/.config")
desktop: (link "desktop" "$HOME/.local/share/applications")
home:    (link "home"    "$HOME")
systemd: (link "systemd" "$HOME/.config/systemd/user")

link package target:
	mkdir -p "{{target}}"
	stow --verbose=2 -t "{{target}}" "{{package}}"
