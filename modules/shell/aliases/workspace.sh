#alias qworkspace-rename='$DOTFILES/modules/xfce/rename-xfce-workspace/rename-xfce-workspace/rename-xfce-workspace'
function qworkspace-getname() {
  wmctrl -d | grep '*' | sed 's/.* //g'
}

function qworkspace-rename() {
    # Current workspace output by wmctrl
    curnt_ws_idx=$(wmctrl -d | grep '*' | cut -d " " -f1) # current workspace id

    # Get the names of all the workspaces
    ws_names=()
    while read name; do
	ws_names+=("$name")
    done < <(xfconf-query -c xfwm4 -p /general/workspace_names | tail -n +3)

    # Get new workspace name via zenity
    new_name=$(zenity --entry --title="Rename workspace" \
	--text="Rename workspace $((curnt_ws_idx + 1))" --entry-text="${ws_names[$curnt_ws_idx]}")

    # Update the names of all the workspaces (they could have changed in the meanwhile)
    ws_names=()
    while read name; do
	ws_names+=("$name")
    done < <(xfconf-query -c xfwm4 -p /general/workspace_names | tail -n +3)

    # Overwrite current workspace name
    xfconf_cmd="xfconf-query -c xfwm4 -p /general/workspace_names"
    for i in ${!ws_names[@]}; do
	if [[ $i == $curnt_ws_idx && $new_name ]]; then
	    xfconf_cmd+=" -s \"$new_name\""
	else
	    xfconf_cmd+=" -s \"${ws_names[$i]}\""
	fi
    done
    eval $xfconf_cmd
}

function qworkspace-bring-window() {
  local window_exp="$1"
  if [ ! -z "$window_exp" ]
  then
    wmctrl -R "$window_exp"
  fi
}

function qworkspace-goto-window() {
  local window_exp="$1"
  if [ ! -z "$window_exp" ]
  then
    wmctrl -a "$window_exp"
  fi
}
