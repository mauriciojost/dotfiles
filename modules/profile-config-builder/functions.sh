#!/bin/bash

files_differ () {
    ! diff "$1" "$2" &> /dev/null
}

run () {
    echo Running "$@"
    "$@"
}

copy_tree () {
    set +x 
    local CREATE_BACKUP=false
    local LIST=SRC
    local FILTER='*'
    local METHOD="cp -f"

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

    set -x 
}

