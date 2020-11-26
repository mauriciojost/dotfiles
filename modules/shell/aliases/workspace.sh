function qworkspace-list() {
  # Get the names of all the workspaces
  ws_names=()
  while read name; do
    echo "$name"
  done < <(xfconf-query -c xfwm4 -p /general/workspace_names | tail -n +3)
}

function qworkspace-getidx() {
  wmctrl -d | grep '*' | cut -d " " -f1
}

function qworkspace-getname() {
  # current workspace index
  curnt_ws_idx="$(qworkspace-getidx)"
  # Get the names of all the workspaces
  ws_names=()
  while read name; do
    ws_names+=("$name")
  done < <(xfconf-query -c xfwm4 -p /general/workspace_names | tail -n +3)
  echo "${ws_names[$curnt_ws_idx]}"
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
    new_name_raw=$(zenity --entry --title="Rename workspace" \
	--text="Rename workspace $((curnt_ws_idx + 1))" --entry-text="${ws_names[$curnt_ws_idx]}")
    new_name="$(echo ${new_name_raw,,} | sed 's# ##g')"

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

function qworkspace-take-window() {
  local window_exp="$1"
  if [ ! -z "$window_exp" ]
  then
    wmctrl -r "$window_exp" -t 0
  fi
}

function qworkspace-take-window-id() {
  local window_id="$1"
  if [ ! -z "$window_id" ]
  then
    wmctrl -i -r "$window_id" -t 0
  fi
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

function qworkspace-goto-window-id() {
  local window_id="$1"
  if [ ! -z "$window_id" ]
  then
    wmctrl -i -a "$window_id"
  fi
}

function qworkspace-list-apps-csv() {
  echo "wid^id^name"
  wmctrl -l | awk -F' ' '{i=$1; w=$2; h=$3; $1=$2=$3=""; print w "^" i "^" $0}'| sed -E 's/\^ +/\^/g' | sort -n
}

function qworkspace-list-csv() {
  echo "id^name"
  wmctrl -d | awk -F' ' '{i=$1; $1=$2=$3=$4=$5=$6=$7=$8=$9=""; print i "^" $0}' | sed -E 's/\^ +/\^/g' | sort -n
}

function qworkspace-list-windows() {
  local d="$(mktemp -d)"
  cd "$d"
  qworkspace-list-apps-csv > apps
  qworkspace-list-csv > works
  python2-q-text-as-data --output-delimiter='^' -b --output-header --skip-header --delimiter='^' "select w.name as workspace,a.name as application, a.id as application_id from apps as a join works as w where a.wid = w.id"
  rm apps works
  cd -
  rmdir "$d"
}

function br() {
  local name="$1"
  if [ "$name" == "" ]
  then
    qworkspace-list-windows | fzf | qworkspace-bring-window-id "$(awk -F^ '{print $3}')"
  else
    qworkspace-bring-window "$name"
  fi
}

function ta() {
  local name="$1"
  if [ "$name" == "" ]
  then
    qworkspace-list-windows | fzf | qworkspace-take-window-id "$(awk -F^ '{print $3}')"
  else
    qworkspace-take-window "$name"
  fi
}


function go() {
  local name="$1"
  if [ "$name" == "" ]
  then
    qworkspace-list-windows | fzf | qworkspace-goto-window-id "$(awk -F^ '{print $3}')"
  else
    qworkspace-goto-window "$name"
  fi
}

function qworkspace-tidy() {
  qworkspace-list-apps-csv > apps
  qworkspace-list-csv > works
  cat works | while read ws
  do
    if [ "$ws" != "id^name" ] # skip header
    then
      ws_id="$(echo "$ws" | awk -F^ '{print $1}')"
      ws_name="$(echo "$ws" | awk -F^ '{print $2}')"
      if [ "$ws_name" != "-" ]
      then
	cat apps | while read app
	do
	  if [ "$app" != "wid^id^name" ] # skip header
	  then
	    app_id="$(echo "$app" | awk -F^ '{print $2}')"
	    app_name="$(echo "$app" | awk -F^ '{print $3}')"
	    if [[ "${app_name,,}" == *"${ws_name,,}"* ]]; then
	      echo "$app_name($app_id) -> $ws_name($ws_id)"
	      wmctrl -i -r $app_id -t $ws_id
	    fi
	  fi
	done
      fi
    fi
  done
}

