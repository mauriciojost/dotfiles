function qstderred-build(){
  cd $HOME/opt/
  git clone https://github.com/sickill/stderred.git
  cd stderred
  make universal
}

function qstderred-load(){
  echo export LD_PRELOAD="$HOME/opt/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
}
