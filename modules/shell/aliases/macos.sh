if [ "$machine_os" == "macos" ]; then
  # allow repeating key https://stackoverflow.com/questions/39606031/intellij-key-repeating-idea-vim
  defaults write -g ApplePressAndHoldEnabled -bool false
  echo "Keyboard -> Modifier Keys -> Globe : Control" # rewrite fn (useless) into Control
  echo "Spotlight -> Show Spotlight search: ^Space" # spotlight with ^control / fn and space

  # more stuff to come
fi
