
# Screenshot
function qscreenshot-region-file() {
   local ld=`cat ~/.last-dir`
   local new_name=$(zenity --entry --title="Name" --text="Filename" --entry-text="$RANDOM-$RANDOM")
   local newoutputfile="$ld/$new_name.png"
   echo "Will save to: $newoutputfile (change directory using sd command)"
   echo "Select region using mouse..."
   gnome-screenshot -a -f "$newoutputfile"
   echo ""
   echo "Output file at: $newoutputfile"
}

# Screenshot from a region and put in the clipboard
function qscreenshot-region-clipboard() {
   echo "Select region using mouse..."
   gnome-screenshot -a -c
   echo "Output is on the clipboard"
}

