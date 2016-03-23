function qmount-shared-vbox-directory() {
    mkdir -p /tmp/workspace-host
    sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) Z_DRIVE /tmp/workspace-host
}

