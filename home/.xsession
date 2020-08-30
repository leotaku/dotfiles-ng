# Environment
export TERMINAL="urxvtc"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_SCALE_FACTOR="1.0"

# Setup keybindings
xcape -e 'ISO_Level3_Shift=Escape'
xcape -e 'Alt_L=Control_L|G'

# Load Xresources
xrdb -merge "$HOME/.config/Xresources"
xrdb -merge "$HOME/.config/XresourcesColors"

# Systemd setup
systemctl --user import-environment

# Lorri does not work as a systemd service
nohup lorri daemon &>/dev/null &

awesome
