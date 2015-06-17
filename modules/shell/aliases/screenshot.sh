
# Screenshot
function qscreenshot-region-file() {
   echo "Select region using mouse..."
   gnome-screenshot -a 
   export outputfile=$(ls -t "$HOME" | grep png | head -1 | xargs -I % readlink -e "$HOME/%")
   export newoutputfile="/tmp/$RANDOM-$RANDOM-$RANDOM.png"
   echo "Moving from $outputfile to $newoutputfile..."
   mv "$outputfile" "$newoutputfile"
   echo "Output file at: $newoutputfile"
}

# Screenshot
function qscreenshot-region-clipboard() {
   echo "Select region using mouse..."
   gnome-screenshot -a -c
   echo "Output is on the clipboard"
}

