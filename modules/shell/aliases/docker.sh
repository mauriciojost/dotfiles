##################### 
### DOCKER

# List running containers
alias qdock-ps="sudo docker ps"

# Kill a running list of containers
alias qdock-kill="sudo docker kill"

# Get details of a running container
alias qdock-details="sudo docker inspect"

# Get list of existent images
alias qdock-images="sudo docker images"

# Copy files to container
alias qdock-scp="sudo docker cp"

function qdock-free-disk-space() {
  sudo docker system prune
  sudo docker image prune -a
}


function qdock-create-container-from-image-X-and-start-it() {
  sudo docker images
  local cntr=`sudo docker create "$1"`
  sudo docker start "$cntr"
}

function qdock-ip() {
  sudo docker inspect $1 | grep IPAddress
}

