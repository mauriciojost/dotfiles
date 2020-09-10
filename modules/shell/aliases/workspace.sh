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

function qworkspace-bring-window-id() {
  local window_id="$1"
  if [ ! -z "$window_id" ]
  then
    wmctrl -i -R "$window_id"
  fi
}

function qworkspace-goto-window() {
  local window_exp="$1"
  if [ ! -z "$window_exp" ]
  then
    wmctrl -a "$window_exp"
  fi
}

function qworkspace-list-windows() {
  echo "wid^id^name" > apps
  wmctrl -l | awk -F' ' '{i=$1; w=$2; h=$3; $1=$2=$3=""; print w "^" i "^" $0}'| sed -E 's/\^ +/\^/g' | sort -n >> apps
  echo "id^name" > works
  wmctrl -d | awk -F' ' '{i=$1; $1=$2=$3=$4=$5=$6=$7=$8=$9=""; print i "^" $0}' | sed -E 's/\^ +/\^/g' | sort -n >> works
  python2-q-text-as-data --output-delimiter='^' -b --output-header --skip-header --delimiter='^' "select w.name as workspace,a.name as application, a.id as application_id from apps as a join works as w where a.wid = w.id"
}

function qworkspace-bring() {
  qworkspace-list-windows  | fzf | qworkspace-bring-window-id "$(awk -F^ '{print $3}')" # something is wrong, stuff with chars [ and ] do not match
}

