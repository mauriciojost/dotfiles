function qlog-system-list() {
	dmesg | less
	echo "Listing syslog..."
	sleep 2
	less /var/log/syslog 
}

function qstats-base() {
	# Install sysstat
	INTERVAL=1
	COUNT=10000
	sar $@ $INTERVAL $COUNT
}

function qstats() {
    qstats-base -W -F -u
}

function qstats-help(){
    sar -h
}
function qstats-I-interrupts-statistics() {
    qstats-base -I
}
function qstats-F-filesystem-statistics() {
    qstats-base -F
}
function qstats-u-cpu-utilization-statistics() {
    qstats-base -u
}
function qstats-d-block-device-statistics() {
    qstats-base -d
}
function qstats-v-kernel-table-statistics() {
    qstats-base -v
}
function qstats-W-swap-statistics() {
    qstats-base -W
}
function qstats-B-paging() {
    qstats-base -B
}
function qstats-b-io-transfer-rate-statistics() {
echo tps: Total num­ber of trans­fers per sec­ond that were issued to the phys­i­cal disk. A trans­fer is an I/O request to the phys­i­cal disk. Mul­ti­ple log­i­cal requests can be com­bined into a sin­gle I/O request to the disk. A trans­fer is of inde­ter­mi­nate size.
echo rtps: Total num­ber of read requests per sec­ond issued to the phys­i­cal disk.
echo wtps: Total num­ber of write requests per sec­ond issued to the phys­i­cal disk.
echo bread/s: Total amount of data read from the drive in blocks per sec­ond. Blocks are equiv­a­lent to sec­tors with 2.4 ker­nels and newer and there­fore have a size of 512 bytes. With older ker­nels, a block is of inde­ter­mi­nate size.
echo bwrtn/s: Total amount of data writ­ten to the drive in blocks per second.

    qstats-base -b
}
function qstats-q-queue-and-load-average-statistics() {
    qstats-base -q
}
function qstats-R-memory-statistics() {
    qstats-base -R
}
function qstats-r-memory-utilization-statistics() {
    qstats-base -r
}
function qstats-S-swap-space() {
    qstats-base -S
}
function qstats-w-task-creation-switching-statistics() {
    qstats-base -w
}
function qstats-y-tty-devices-statistics() {
    qstats-base -y
}

function qstress-base() {
    stress $@ --timeout 1000s
}

function qstress-c-cpu() {
    qstress-base -c 10
}
function qstress-i-io() {
    qstress-base -i 10
}
function qstress-m-memory() {
    qstress-base -m 10
}

function qstress-X-context-switching() {
    for i in `seq 1000000`; do echo echo; done
}

function qstress-X-process-switching() {
    for i in `seq 50000`
    do 
      hostname &
    done
}

alias qfiles-opened-by-process-list='lsof -a -i -p'

alias qports-list-listening='sudo lsof -i -n -P | grep LISTEN'

alias qports-list-all='sudo lsof -i -n -P'


