function qsparkshell-with-packages() {
  local packs_coords_list=${1:-"com.beachape:enumeratum_2.12:1.5.15"}
  spark-shell --packages "$packs_coords_list"
}
