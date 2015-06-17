
files_differ () {
    ! diff "$1" "$2" &> /dev/null
}

run () {
    echo Running "$@"
    "$@"
}

copy_tree () {

    TIMESTAMP=$(date +%Y%m%d%H%M%S)

    if [ -z $1 -o -z $2 ]
    then
      echo Need to provide src and dst.
      exit 0
    fi

    local CREATE_BACKUP=true
    local LIST=SRC
    local FILTER='*'
    local METHOD="cp -f"

    while [ $# -gt 2 ]; do
	    case "$1" in
	        --no-backup)
		        CREATE_BACKUP=false
		        shift
		        ;;
	        --list-files-in-dest)
		        LIST=DEST
		        shift
		        ;;
	        --filter)
		        FILTER="$2"
		        shift 2
		        ;;
            --symlink)
                METHOD="ln -s"
                shift
                ;;
	        *)
		        echo Unrecognized option "$1"
		        return 1
		        ;;
	    esac
    done

    local SRC="$1"
    local DEST="$2"

    # resolve indirect refernce
    LIST=${!LIST}

    while read FILE; do
	    case "$FILE" in
            ./.git/*)
                continue
                ;;
	        ./$FILTER)
		        ;;
	        *)
		        echo Filtered out "$FILE"
		        continue
		        ;;
	    esac

	    DEST_FILE="$DEST"/"$FILE"
	    DEST_DIR=$(dirname "$DEST_FILE")
	    SRC_FILE=$SRC/$FILE
	    [ -d "$DEST_DIR" ] || mkdir -p "$DEST_DIR"
	    if [ -f "$DEST_FILE" ]; then
	        if files_differ "$SRC_FILE" "$DEST_FILE"; then
		        if [ "$CREATE_BACKUP" = "true" ]; then
		            run cp -L "$DEST_FILE" "$DEST_FILE".$TIMESTAMP
                    rm -f "$DEST_FILE"
		        fi
		        run $METHOD "$SRC_FILE" "$DEST_FILE"
	        else
		        echo Not copying, identical "$SRC_FILE" "$DEST_FILE"
	        fi
	    else
	        run $METHOD "$SRC_FILE" "$DEST_FILE"
	    fi
    done < <(cd $LIST; find . -type f)
}


