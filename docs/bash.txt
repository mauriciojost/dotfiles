### BASH

##Shortcuts
alt n + alt . 
insert the n-th argument of the last command in the current command line 

ctrl + /                      undo in the command line
alt + #                      add to the history the current command 
alt + <-                     (backspace) delete word backwards 
ctrl + L                    clear screen 

## Basics 
Put in variables the output of one process 

variable=’ls’  -> variable=ls
variable=$(ls) -> variable= . .. /home /etc /var ...


## Get values returned by the last command 
true
echo $?            >      0
false 
echo $?            >      1



## List files 

for FILE in *
do
	echo $FILE
done

## Using the test command 

mjost:~/Downloads/$ help test

## Comparing strings

if [ "$(ls $FILE)" == 'tocopy' ]
then
	echo yes
else
	echo no 
fi

## Checking if an environment variable is empty

keywords exists set variable exist exists check test empty
if [ "$variable" ]
then
   echo variable EMPTY OR NOT DEFINED;
else
   echo variable DEFINED and NOT empty;
fi

## Checking if a file exists 

if [ -e "$FILE" ]
then
  echo "$FILE exists"
else
  echo "$FILE not found"
fi


### Others 
### Executing a test command 

test 3 -gt 4 && echo True || echo False

### Reading from file 
exec<file_to_read     # exec is a reserved word
while read line
do
       echo $line
done

### Read from a  pipe 
### keywords read reading pipe bash script 
### It is the same as reading a file, you just remove the exec line

while read line
do
       echo $line
done

### Examples 
### Create a counter 
keywords while for loop bash

linecounter=0
while true
do
       linecounter=`expr $linecounter + 1`;
       echo $linecounter
done


### Simple for

for VARIABLE in `seq 1 10`
do
  echo $VARIABLE
done

### Command line arguments 

for opt in $@
  case $opt in
    -i) input_file=$2 ; shift 2 ;;  # reading $2 grabs the *next* fragment
    -o) output_file=$2 ; shift 2 ;; # shift 2 to get past both the -o and the next
  esac


### Write a head-like command 
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

### Fork a process and get its PID

$ sleep 30 &
$ process_pid=$!

### Now the PID is in process_pid variable. 

To wait for this process and then perform a different action: 

$ wait $process_pid

Or if the process was not created by you, you can attach a strace to the observed process and wait for the strace. 

strace -s 0 -p PID && echo “TARGET PROCESS FINISHED!”


### Catching a SIGINT
### keywords interrupt interruption bash catching ctrl ctrl-c sigterm kill linux bash script hook 

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

### Using extra commands 
### Use sed 

keywords replace substitute text in a file regular expression regex 
$ sed ‘s/wrong/ok/g’ source_file > destination_file
s stands for search, and g means global (replace all occurrences, not only the first one)

### Use awk 

$ cat text.txt
lakjdflkajsdfalsdjf mauri adsfkljasdlkjasd 3
alsfjalskdjflads sandun jdalkdsjflkajsdf 2
lñajsdñfkjasdfkl san
lañdsjfasdñljadslfkjasd







$ cat text.txt | awk ' /maur/ {print "echo "$2" > file.txt"}' | bash


$ cat file.txt
mauri


EXAMPLES
EXAMPLE 1

# Script that checks if root, checks if folders are created, 
#/bin/bash

export PAUSER='proactive'
# PAPASS can be generated with command: $ openssl passwd password 
export PAPASS='XXX' 
export PAGROUP='proactivegroup'

export PIDFILE="PID"
export CONFIGXMLOUT="config.xml"

export CONFIGXMLBASE="config-base.xml"
export PROACTIVEBASE='schedworker-3.3.2/'
export CREDPATH="config/authentication/rm.cred"
export USRSBIN="/usr/sbin"
export SCRIPTNAME="start-agent"
export PAADIRNAME="proactive-agent"
export ALREADYCONFFILE="SKIPCONFIGURATION"
export JAVAINOPT="java-for-paagent"
export HACKENVDASHFILE="envwrapper"

assertexists(){
	# $1 file $2 message
	if [ -e "$1" ]
	then
		echo "File existence checked for: $1"
	else
		echo "$2"
		exit 1
	fi
}
        
assertdoesnotexist(){
	# $1 file $2 message
	if [ -e "$1" ]
	then
		echo "$2"
		exit 1
	fi
}

checkcurrdir(){ 

	if [ -e "$PWD/proactive-agent" ]
	then
		echo "Executable $PWD/proactive-agent checked."
	else
		echo ">>> Please go to the root of the project before running the script."
		exit 1
	fi 

	if [ "$PWD" = "/opt/$PAADIRNAME" ]
	then
		echo "Running from /opt/$PAADIRNAME : OK."
	else
		echo ">>> Not running from /opt/$PAADIRNAME"
		echo "Please place the current directory in /opt with the following command: "
		echo "       $ sudo mv ../$PAADIRNAME /opt"
		echo "and proceed as follows:"
		echo "       $ cd /opt/$PAADIRNAME"
		echo "       $ sudo ./$SCRIPTNAME "
		exit 1
	fi 

	echo "Current directory: OK."
}

checkifroot(){
	LUID=$(id -u)
	if [ $LUID -ne 0 ]; then
		echo ">>> This script must be run as root."
		exit 1
	fi
	echo "Running as root: OK."
}

assertnotempty(){
	# $1 variable $2 errormessageifempty
	# assert the variable is not empty
	if [ -z "$1" ]
	then
		echo "$2"
		exit 1
	fi
}

setupuser(){ # Create a user if it does not exist
	# $1 PAUSER $2 PAPASS

	set +e 
	OUTPUT=$(id "$1")
	CODEOUTPUT=$?
	set -e 

        if [ "$CODEOUTPUT" -eq 0 ]
        then
		echo "User $1 already exists. Use this existing user to run the agent? (yes, [no])" 
		read PROCEED

		if [ "$PROCEED" = "yes" ]
		then 
			echo "Using existing $1 user."
		else
			echo "Stop."
			exit 0
		fi
	else
		echo "User $1 DOES NOT exist, creating..."
		createuser "$1" "$2"
		echo "Done."
	fi	

	checkuser "$1"
}

setuniquegrouptouser(){
	#$1 group $2 user
	$USRSBIN/usermod -g "$1" "$2"
}

addtogrouptheuser(){
	#$1 group $2 user
	if [ "$(echo $CURRLINUXDIST | grep -i opensuse)" ]
	then 
		echo "   openSUSE usermod command..."
		$USRSBIN/usermod -A "$1" "$2"
	else
		echo "   Standard usermod command..."
		$USRSBIN/usermod -aG "$1" "$2"
	fi
}

makeenvhackubuntudash(){
	#$1 group $2 user
	#$1 PROACTIVEBASE" $2 HACKENVDASHFILE
	if [ "$(echo $CURRLINUXDIST | grep -i ubuntu)" ]
	then 
		echo "   Ubuntu hack for dash shell being applied..."
		mv "$1"/bin/unix/env "$1"/bin/unix/env_original
		cp "$CURRDIR"/"$2" "$1"/bin/unix/env
	fi
}

setupgroup(){
	# $1 PAGROUP $2 USER 

	GROUPCHECK="^$1:"
        if [ "$(egrep -i $GROUPCHECK /etc/group)" ]
        then
		echo "Group $1 already exists."
	else
		echo "Group $1 DOES NOT exist, creating..."
		echo "Creating group $1..."
		$USRSBIN/groupadd "$1"
		echo "Done."
	fi	

	setuniquegrouptouser "$1" "$2"

	echo "Do you want to add user $SUDO_USER to group $1 to be able to see log files? (yes, [no])" 
	read PROCEED # read user input

	if [ "$PROCEED" = "yes" ]
	then 
		echo "Adding user $SUDO_USER to group $1 ..."
		addtogrouptheuser "$1" "$SUDO_USER"
		echo "Done."
	else
		echo "Skipping... You can do it later manually with the command: "
		echo "   sudo $USRSBIN/usermod -aG $1 $SUDO_USER"
		echo "    or " 
		echo "   sudo $USRSBIN/usermod -A $1 $SUDO_USER"
		echo "   depending on your linux distribution."
	fi
}

createuser(){ # create a new user
	# $1 PAUSER $2 PASS
	echo "Creating user $1..."
	$USRSBIN/useradd -m -s /bin/bash $1 --password $2
	echo "Done."
}

checkproactive(){
	# $1 PROACTIVEBASE
	export PROACTIVE_HOME=$(readlink -e $1)

	if [ -e "$PROACTIVE_HOME/bin/unix/rm-start-node" -a -e "$PROACTIVE_HOME" ]
	then
		echo "PROACTIVE_HOME : OK."
	else
		echo "ERROR: PROACTIVE_HOME does NOT SEEM to be correct, no $PROACTIVE_HOME/bin/unix/rm-start-node found."
		exit 1
	fi
}

checkjava(){ # check if java is installed
	# $1 JAVAENV $2 JAVAPARAM

	export JAVAPATH="$1"

	if [ "$JAVAPATH" ] 
	then
		if [ -e "$JAVAPATH/bin/java" -a -e "$JAVAPATH" ] 
		then
			echo "JAVA path (obtained from environment variable) : OK   $JAVAPATH"
			return
		else
			echo "JAVA path provided through environment variable JAVA_HOME, invalid path detected: $JAVAPATH (no $JAVAPATH/bin/java detected)"
		fi
	else
		echo "JAVA not provided through environment variable JAVA_HOME."
	fi

	export JAVAPATH="$2"

	if [ "$JAVAPATH" ] 
	then
		if [ -e "$JAVAPATH/bin/java" -a -e "$JAVAPATH" ] 
		then
			echo "JAVA path (obtained from parameter) : OK   $JAVAPATH"
			return
		else
			echo "JAVA path passed as parameter, invalid path detected: $JAVAPATH  (no $JAVAPATH/bin/java detected)"
		fi
	else
		echo "JAVA not provided as parameter."
	fi

	echo "ERROR: JAVA path not correctly specified. "
	echo "       Specify the JAVA path either as first parameter of the script:  "
	echo "         $ sudo ./$SCRIPTNAME /path/to/jre"
	echo "       or setting the environment variable JAVA_HOME:"
	echo "         $ export JAVA_HOME=/path/to/jre"
	echo "         $ sudo ./$SCRIPTNAME"
	echo "                  or "
	echo "         $ sudo -E ./$SCRIPTNAME"
	echo "              to inherit environment variables, depending on the Linux distribution."
	exit 1


}

checkjavaperm(){ # check for file access permission
	# $1 JAVAPATH 

	assertnotempty "$1" "ERROR: the parameter cannot be empty."

	set +e 
	OUTPUT="$(sudo -u $PAUSER $1/bin/java)"
        CODEOUTPUT=$?
	set -e 

        if [ ! "$CODEOUTPUT" -eq 0 ]
	then 
		echo ">>> Cannot have full access to directory $1 as user $PAUSER."
		echo "Do you want to create an accessible copy of this java package in /opt ? (yes, [no])" 
		read PROCEED

		if [ "$PROCEED" = "yes" ]
		then 
			echo "Copying from $1 to /opt/$JAVAINOPT"
			if [ -e "/opt/$JAVAINOPT" ]
			then
				echo ">>> Directory /opt/$JAVAINOPT already exists. Remove it first."
				exit 1
			fi

			cp -r "$1" "/opt/$JAVAINOPT"
			chmod -R u+Xrw "/opt/$JAVAINOPT"
			chown -R "$PAUSER:$PAGROUP" "/opt/$JAVAINOPT"
			export JAVAPATH="/opt/$JAVAINOPT"
			if [ -z "$(sudo -u $PAUSER readlink -e $JAVAPATH/bin/java)" ]
			then 
				echo "ERROR: after putting java in /opt there is still a problem with permissions."
				exit 1
			else
				echo "JAVA permissions in the new directory: OK."
			fi
		else
			echo ">>> Stop."
			echo "Try changing the permissions of this java directory so that"
			echo "the user $PAUSER can access it."
			echo "Check it with the command: "
			echo "  sudo -u $PAUSER JAVAPATH/bin/java"
			exit 1
		fi
	else
		export JAVAPATH="$(readlink -e $1)"
		echo "It is accessible: $JAVAPATH" 
	fi
}


assertexecutes(){
  # $1 executablefile $2 message
  set +e 
  OUTPUT=`$1`
  CODEOUTPUT=$?
  set -e 

  if [ ! "$CODEOUTPUT" -eq 0 ]
  then
    echo "$2"
    exit 1
  else
    echo "File execution checked for: $1"
  fi
}

syncremote(){
  # $1 source@path $2 target@path
  rsync --checksum -avzrP --inplace --delete “$1“ “$2“
}

setupconfigxml(){
	# $1 JAVAPATH $2 PROACTIVEHOME $3 CREDENTIAL $4 BASECONFIG $5 DESTCONFIG
	cp -f "$4" "$5"

	JAVAPATHA=$(     echo "$1" | sed 's/(/\\\(/g' | sed 's/)/\\\)/g'| sed 's/\//\\\//g')
	PROACTIVEHOMEA=$(echo "$2" | sed 's/(/\\\(/g' | sed 's/)/\\\)/g'| sed 's/\//\\\//g')
	CREDENTIALA=$(   echo "$3" | sed 's/(/\\\(/g' | sed 's/)/\\\)/g'| sed 's/\//\\\//g')

	#echo "JAVA_HOME is:      $JAVAPATHA"
	#echo "PROACTIVE_HOME is: $PROACTIVEHOMEA"
	#echo "CREDENTIAL is:     $CREDENTIALA"

	sed -i \
            -e "s/JAVAHOMEXXX/$JAVAPATHA/g" \
            -e "s/PROACTIVEHOMEXXX/$PROACTIVEHOMEA/g" \
            -e "s/CREDENTIALXXX/$CREDENTIALA/g" "$5" 
}

checkrmcred(){
	# $1 CREDPATH 
	export CREDENTIAL=$(readlink -e $1)

	if [ -e "$CREDENTIAL" ]
	then
		echo "CREDENTIAL : OK."
	else
		echo "ERROR: CREDENTIAL does NOT SEEM to be correct, no $CREDENTIAL found."
		exit 1
	fi
		
}

setupcurrdirperm(){ # setup directory permissions
	# $1 CURRDIR $2 PAUSER $3 PAGROUP
	chown -R $2:$3 $1
 	chmod -R ug+Xrw $1 
 	chmod -R o-xrw $1
}

checkuser(){
	#1 USER

	set +e 
	OUTPUT=$(id $1)
	CODEOUTPUT=$?
	set -e 

        if [ "$CODEOUTPUT" -eq 0 ]
        then
		echo "User $1 existence : OK." 
	else
		echo "ERROR: user $1 DOES NOT exist."
		exit 1 
	fi	
}

testpermissions(){
	# $1 CURRDIR 
	if [ -z "$(sudo -u $PAUSER readlink -e $1/proactive-agent)" ]
	then 
		echo "ERROR: cannot have full access to directory $1 as user $PAUSER."
		exit 1
	fi


	sudo -u "$PAUSER" touch "$1/test-file-touch"
	rm "$1/test-file-touch"
	echo "Permissions : OK."
}

function_with_list(){ # use list set of words and iterate over them. list set for 
VAR=""
VAR="$VAR 1" # 1
VAR="$VAR 2" # 1 2 
VAR="$VAR 3" # 1 2 3

echo $VAR # 1 2 3 

for x in $VAR
do
  		echo "value $x" # print one by one at a time
done
}


set -e  # STOP if any error

echo ""
echo "#### PHASE 0 "
echo "############ "
echo ""

echo "#### This script will configure and run the standalone version of the ProActive Agent for Linux."
export CURRDIR="$(dirname $0)"
export CURRLINUXDIST="$(cat /etc/issue)" # Output: Fedora release 17 (Beefy Miracle) Kernel \r on an \m (\l)
export CURRUNAME="$(uname -a)" # Output: Linux dalek.activeeon.com 3.5.5-2.fc17.x86_64 #1 SMP Wed Oct 3 13:20:37 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
export CURRARCH="$(uname -m)" # find out architecture, for instance x86_64 or x86
export JAVAGIVEN="$1"

cd "$CURRDIR"

echo "Current directory is:          $PWD"
echo "Current Linux distribution is: $CURRLINUXDIST"
echo "Current uname is:              $CURRUNAME"
echo "Current architecture is:       $CURRARCH"

echo "#### Checking if running as root..."
checkifroot

echo "#### Checking if the current directory is correct..."
checkcurrdir 

echo "#### Checking if the configuration process can be skipped..."

if [ ! -e "$PWD/$ALREADYCONFFILE" ] # if file does not exist
then 

	echo "#### Configuration process needed. Running for the first time."

	echo ""
	echo "#### PHASE 1 "
	echo "############ "
	echo ""

	echo "#### Checking if user $PAUSER is created, or create if needed..."
	setupuser "$PAUSER" "$PAPASS" 

	echo "#### Checking if group $PAGROUP is created, or create if needed..."
	setupgroup "$PAGROUP" "$PAUSER" 

	echo ""
	echo "#### PHASE 2 "
	echo "############ "
	echo ""

	echo "#### Checking if needed binaries are where expected..."
	assertexists "$USRSBIN/usermod" "ERROR: $USRSBIN/usermod not found."
	assertexists "$USRSBIN/useradd" "ERROR: $USRSBIN/useradd not found."
	assertexists "$USRSBIN/groupadd" "ERROR: $USRSBIN/groupadd not found."

	echo "#### Checking if path to JAVA is correct..."
	checkjava "$JAVA_HOME" "$JAVAGIVEN" 
	echo "#### Checking if path to JAVA is accessible..."
	checkjavaperm "$JAVAPATH"

	echo "#### Checking if PROACTIVE_HOME is correct..."
	checkproactive "$PWD/$PROACTIVEBASE" 

	echo "#### Checking if CREDENTIAL is correct..."
	checkrmcred "$PROACTIVEBASE/$CREDPATH"

	echo ""
	echo "#### PHASE 3 "
	echo "############ "
	echo ""

	echo "#### Setting up ProActive Agent configuration file..."
	echo "   Using:"
	echo "      JAVAPATH         $JAVAPATH"
	echo "      PROACTIVE_HOME   $PROACTIVE_HOME"
	echo "      CREDENTIAL       $CREDENTIAL"
	echo "   Writing to $PWD/$CONFIGXMLOUT..."

	assertnotempty "$JAVAPATH"      "ERROR: environment variable JAVAPATH not set."
	assertnotempty "$PROACTIVE_HOME" "ERROR: environment variable PROACTIVE_HOME not set."
	assertnotempty "$CREDENTIAL"     "ERROR: environment variable CREDENTIAL not set."

	setupconfigxml "$JAVAPATH" "$PROACTIVE_HOME" "$CREDENTIAL" "$PWD/$CONFIGXMLBASE" "$PWD/$CONFIGXMLOUT"
	echo "   Done."

	echo "   Checking if additional OS based actions are required..."
	makeenvhackubuntudash "$PROACTIVEBASE" "$HACKENVDASHFILE"

	echo ""
	echo "#### PHASE 4 "
	echo "############ "
	echo ""

	echo "#### Setting up permissions of the current directory..."
	setupcurrdirperm "$PWD" "$PAUSER" "$PAGROUP"

	echo "#### Testing permissions..."
	testpermissions "$PWD" 

else

	echo "#### Skipping configuration..."

fi

echo ""
echo "####   RUN   "
echo "############ "
echo ""

export PIDFILEABS="$(readlink -f $PWD/$PIDFILE)"
export CONFIGFILEABS="$(readlink -e $PWD/$CONFIGXMLOUT)"
export CURRDIRABS="$(readlink -e $PWD)"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CURRDIRABS"
export PYTHON_PATH="$PYTHON_PATH:$CURRDIRABS"

assertdoesnotexist "$PIDFILEABS" "ERROR: the file $PIDFILEABS exist, so probably the daemon proactive-agent is already running. Kill it before continuing."

set +e 
sudo -u "$PAUSER" "$PWD/proactive-agent" -D -v "$CONFIGFILEABS" -p "$PIDFILEABS" 
set -e 

sleep 2 

echo "Agent user            : $PAUSER"
echo "Agent PID             : $(cat $PIDFILEABS)"
echo "Agent logs folder     : $CURRDIRABS"
echo "Agent logs main file  : $CURRDIRABS/$(ls $CURRDIRABS | grep log | head -1)"
echo "Agent docs main file  : $CURRDIRABS/README.txt"
echo "Agent PID file        : $PIDFILEABS"
echo "Agent conf. file used : $CONFIGFILEABS"

assertexists "$PIDFILEABS" "ERROR: the agent is not running."

touch "$PWD/$ALREADYCONFFILE"
echo "OK: agent running."




Create a self-extracting binary file


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


self-extracting-installer-header.sh

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



