# List files 

```
for FILE in *
do
	echo $FILE
done
```

# Using the test command 

```
mjost:~/Downloads/$ help test
```

# Comparing strings

```
if [ "$(ls $FILE)" == 'tocopy' ]
then
	echo yes
else
	echo no 
fi
```

# Checking if an environment variable is empty

keywords exists set variable exist exists check test empty
```
if [ "$variable" ]
then
   echo variable EMPTY OR NOT DEFINED;
else
   echo variable DEFINED and NOT empty;
fi
```

# Checking if a file exists 

```
if [ -e "$FILE" ]
then
  echo "$FILE exists"
else
  echo "$FILE not found"
fi
```


# Executing a test command 

```
test 3 -gt 4 && echo True || echo False
```

# Reading from file 
```
while IFS= read -r line
do
  echo "$line"
done < "$input"

```

# Read from a  pipe 

```
while read line
do
       echo $line
done
```

```
cat file.txt | while read p; do echo "$p"; done
```

# Create a counter 

keywords while for loop bash

```
linecounter=0
while true
do
       linecounter=`expr $linecounter + 1`;
       echo $linecounter
done
```

# A for construct

```
for VARIABLE in `seq 1 10`
do
  echo $VARIABLE
done
```

# Command line arguments 

```
for opt in $@
  case $opt in
    -i) input_file=$2 ; shift 2 ;;  # reading $2 grabs the *next* fragment
    -o) output_file=$2 ; shift 2 ;; # shift 2 to get past both the -o and the next
  esac
```


# Write a head-like command 

```
#!/bin/bash
linestoprint=$1
exec<$2
fileoutput=$3
linecounter=0
rm -fr $fileoutput

while read line
do

        linecounter=`expr $linecounter + 1`;
        if test $linecounter -gt $linestoprint
        then
                echo Break here.
                break;
        fi
        echo $line : $linecounter : $linestoprint
        echo $line >> $fileoutput
done
```

# Fork a process and get its PID

```
$ sleep 30 &
$ process_pid=$!
```

# Now the PID is in process_pid variable. 

To wait for this process and then perform a different action: 

```
$ wait $process_pid
```

Or if the process was not created by you, you can attach a strace to the observed process and wait for the strace. 

```
strace -s 0 -p PID && echo “TARGET PROCESS FINISHED!”
```


# Catching a SIGINT

keywords interrupt interruption bash catching ctrl ctrl-c sigterm kill linux bash script hook 

```
#!/bin/bash 
cleanup()
# example cleanup function
{
  rm -f /tmp/tempfile
  return $?
}
control_c()
# run if user hits control-c
{
  echo -en "\n*** Ouch! Exiting ***\n"
  cleanup
  exit $?
}
# trap keyboard interrupt (control-c)
trap control_c SIGINT
# main() loop
while true; do read x; done
```

# Use sed 

keywords replace substitute text in a file regular expression regex 
```
$ sed ‘s/wrong/ok/g’ source_file > destination_file
s stands for search, and g means global (replace all occurrences, not only the first one)
```

# Use awk 

```
$ cat text.txt
lakjdflkajsdfalsdjf mauri adsfkljasdlkjasd 3
alsfjalskdjflads sandun jdalkdsjflkajsdf 2
lñajsdñfkjasdfkl san
lañdsjfasdñljadslfkjasd
$ cat text.txt | awk ' /maur/ {print "echo "$2" > file.txt"}' | bash

# Create a self-extracting binary file


```
BUILD.sh


TARGETFOLDER1=x86
PROJECTFOLDER=proactive-agent
COMPRESSEDFILE=proactive-agent.tar.gz
BUILDFOLDER=output



createbuild(){
	# $1 pathbuild $2 namebuild

	PATHBUILD="$1" # ./x86
	BUILDFILE="$2" # agent.bin

	assertnotempty "$PATHBUILD" "ERROR: PATHBUILD must be provided."
	assertnotempty "$BUILDFILE" "ERROR: BUILDFILE must be provided."
	assertexists "$PATHBUILD" "ERROR: PATHBUILD does not exist."

	rm -f $PATHBUILD/$PROJECTFOLDER/ProActiveAgent-log.tx* $PATHBUILD/$PROJECTFOLDER/SKIPCONFIGURATION

	echo "### Building compressed file $BUILDFILE..."
	cd $PATHBUILD
	tar -czf ../$COMPRESSEDFILE $PROJECTFOLDER
	cd ..
	echo "Done."

	if [ ! -e "$COMPRESSEDFILE" ]; then
		echo "ERROR: $COMPRESSEDFILE could not be created."
		exit 1
	fi

	SUM=$(sum $COMPRESSEDFILE)
	echo "### Creating Self Extracting Installer file $BUILDFILE..."
	cp self-extracting-installer-header.sh header.sh
	sed -i -e "s/TARGETSUMXXX/$SUM/g" header.sh 
	cat header.sh $COMPRESSEDFILE > $BUILDFOLDER/$BUILDFILE
	rm header.sh
	chmod +x $BUILDFOLDER/$BUILDFILE
	rm -f $COMPRESSEDFILE
	echo "Done."

	echo "### Created $BUILDFOLDER/$BUILDFILE : OK"
}
```


self-extracting-installer-header.sh

```
#!/bin/bash

export DESTDIR=/opt
export PAADIR=proactive-agent

checkifroot(){
        LUID=$(id -u)
        if [ $LUID -ne 0 ]; then
                echo ">>> Run this script as root: "
                echo "    $ sudo $0"
                exit 1
        fi
        echo "Running as root: OK"
}

set -e 

echo ""
echo "### ProActive Agent self extracting installer"
echo ""

sleep 1

checkifroot

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`
TARGETSUM="TARGETSUMXXX"

if [ $(which sum) ]
then

	SUM=$(tail -n+$ARCHIVE $0 | sum)

	if [ "$SUM" != "$TARGETSUM" ]
	then 
		echo "ERROR: failed the checksum test..."
		echo "       Please download this executable again."
		exit 1
	else
		echo "Checksum: OK"
	fi
else
		echo "Checksum: (not checked, sum command not available)"
fi


echo "### Installing agent in directory: $DESTDIR/$PAADIR ..."
sleep 1
tail -n+$ARCHIVE $0 | tar xz -C $DESTDIR
echo "Done."    

echo ""
echo ""
echo "### PROACTIVE-AGENT HAS BEEN SUCCESSFULLY INSTALLED!!!"
echo ""
echo "      To launch the agent for the first time proceed as follows:"
echo "         1. Check that the JAVA_HOME environment variable is exported or use this command:"
echo "           $ export JAVA_HOME=/path/to/java"
echo "         2. Run for the first time the agent:"
echo "           $ sudo $DESTDIR/$PAADIR/start-agent " '"$JAVA_HOME"'
echo ""

exit 0

__ARCHIVE_BELOW__

```

## Example of arguments
```
function usage() {
    log "assembly_sbt.sh [ -a airline ] [ -t target1,target2,...,targetn ] [ -s sbtopts ] [ -c ] [ -l ]"
}

while getopts "a:t:s:p:cdoliz" OPT; do
    case "$OPT" in
        a) AIRLINE_CODE="${OPTARG}";;
        t) TARGETS_STR="${OPTARG}";;
        s) SBTOPTS="${OPTARG}";;
        c) COVERAGE="coverage";;
        d) PUBLISH_DOC="Y";;
        p) PROJECT_ID="${OPTARG}";;
        o) OVERRIDE="Y";;
        l) CROSS_COMPILE="+";;
        i) IGNORE_TESTS="Y";;
        z) PUBLISH_ASSEMBLY="N";;
        *) usage; exit 1;;
    esac
done                                                                                                                                

```
