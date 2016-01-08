function qmount-shared-vbox-directory() {
    mkdir -p /tmp/workspace-host
    mkdir -p /tmp/download-host
    sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) workspace /tmp/workspace-host
    sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) download /tmp/download-host
}

