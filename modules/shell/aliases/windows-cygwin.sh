function qcygwin-apt-get() {
  local APT_CYG_PATH=$DOTFILES/modules/cygwin/apt-cyg 
  local APT_CYG_DIR=`basename $APT_CYG_PATH`
  if [ ! -f "$APT_CYG_PATH" ]
  then
    echo "Installing apt-cyg (first time)..."
    mkdir -p "$APT_CYG_DIR"
    curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > $APT_CYG_PATH
  fi

  $APT_CYG_PATH

}
