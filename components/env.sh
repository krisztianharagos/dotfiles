################################ ..ENVS #################################

export MSYS_NO_PATHCONV=1


export BROWSER=$HOME/.local/bin/chrome
export SKAFFOLD_UPDATE_CHECK=false
export PGPASSFILE="$HOME/.pgpass"

# Set environment variables only on my laptop machine
if [[ $HOSTNAME == "BDUWLP879" ]]; then
  export DOCKER_HOST=""
  export DISPLAY=localhost:0.0
fi

# If KUBECONFIG is not configured, set it to default value:
# if ! [[ -f "$KUBECONFIG" ]]; then
#   echo "Setting KUBECONFIG to ~/.kube/config"
#     export KUBECONFIG=~/.kube/config
# fi
