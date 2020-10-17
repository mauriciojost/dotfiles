
# Screenshot
function qscreenshot-region-file() {
   local ld=`cat ~/.last-dirscreenshots`
   local tmp="$(mktemp -u).png"
   echo "Select region using mouse..."
   gnome-screenshot -a -f "$tmp"
   local new_name=$(zenity --entry --title="Screenshot" --text="Filename" --entry-text="$RANDOM-$RANDOM")
   local newoutputfile="$ld/$new_name.png"
   echo "Will save to: $newoutputfile (change directory using 'sd screenshots' command in the desired destination directory)"
   mv "$tmp" "$newoutputfile"
   echo ""
   echo "Output file at: $newoutputfile"
}

# Screenshot from a region and put in the clipboard
function qscreenshot-region-clipboard() {
   echo "Select region using mouse..."
   gnome-screenshot -a -c
   echo "Output is on the clipboard"
}

function qscreenshot-video-gif-window() {
  #sudo add-apt-repository ppa:peek-developers/stable
  #sudo apt update
  #sudo apt install peek
  peek
}

function qscreenshot-video-gif-tty() {
  echo "Type 'exit' or Control-D when finished"
  ttyrec "$videotmp"
  $DOTFILES/modules/ttygif/ttygif/ttygif "$videotmp"
}

