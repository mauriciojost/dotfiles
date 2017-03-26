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

function qdock-ip() {
  sudo docker inspect $1 | grep IPAddress
}

