string="$(maim -us | tesseract - -  | sed -z "s/..$//")"
notify-send "$string"
echo "$string" | xclip -selection clipboard
