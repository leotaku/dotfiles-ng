# Variables

config_dir := "$HOME/.config"

# Commands

stow:
	stow --verbose=2 -t "{{config_dir}}" config
