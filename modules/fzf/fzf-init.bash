if [ "$machine_os" == "linux" ]; then
  if [[ ! "$PATH" == *$HOME/.dotfiles/modules/fzf/fzf/bin* ]]; then # if installed
    export PATH="${PATH:+${PATH}:}$HOME/.dotfiles/modules/fzf/fzf/bin"

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "$HOME/.dotfiles/modules/fzf/fzf/shell/completion.bash" 2> /dev/null

    # Key bindings
    # ------------
    source "$HOME/.dotfiles/modules/fzf/fzf/shell/key-bindings.bash"
  fi
fi
if [ "$machine_os" == "macos" ]; then
  if [ -f /opt/homebrew/bin/fzf ]; then
    echo "Found fzf!!!"
    source "$HOME/.fzf-key-bindings.bash"
  fi
fi
