alias d='sudo docker'
# If user is root no need for sudo
if [[ "$(id -u)" == "0" ]]; then
  alias d='docker'
fi

# If running on Mac (Darwin) no need for sudo
if [[ "$(uname)" == "Darwin" ]]; then
  alias d='docker'
fi

alias di='d images'
alias dps='d ps'
alias dpsa='dps -a'

function dex
{
    d exec -it "$1" /bin/bash
}

# Prune all unused local volumes
function dvp
{
    d volume prune -f
}

alias dco='docker-compose'
alias dcbu='docker-compose build && docker-compose up'
alias doclean='docker rm $(docker ps -a -f status=exited -q)'
alias dosudo='sudo usermod -aG docker $USER'
alias doprune='docker system prune'
alias doi='docker images'
alias dois='docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}:{{.Tag}}" | sort -k 2 -h'
alias dops='docker ps'
alias dodf='docker system df'
alias dotest='docker search ubuntu'
alias dohi=dohi;dohi () {
  docker history --no-trunc "$1" | tac | tr -s ' ' | cut -d " " -f 5- | sed 's,^/bin/sh -c #(nop) ,,g' | sed 's,^/bin/sh -c,RUN,g' | sed 's, && ,\n  & ,g' | sed 's,\s*[0-9]*[\.]*[0-9]*[kMG]*B\s*$,,g' | head -n -1
  }
alias dohis='docker run -v /var/run/docker.sock:/var/run/docker.sock --rm $*'



function dog () {
  x=${1:-""}
	export di=$(docker images --format "table {{.Repository}}:{{.Tag}}" | grep $x)
	echo $di
}

function dor () {
  x=${1:-$di}
  docker run -it --rm --entrypoint sh $x
  # docker run -it --rm -v "${PWD}":/app --entrypoint sh $x
  # docker run -it --rm -v /c/tmp/docker:/app --entrypoint sh $x
}