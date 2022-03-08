alias k='kubectl'
alias kg='k get'
alias kd='k describe'
alias kc='k config'
alias kcc='echo "$(kubectl config current-context)"'
alias kcg='k config get-contexts -o name'
alias kcu='k config use-context'

alias mk='minikube'
alias mks='mk start'
#alias mks='mk start --memory 8192 --cpus 4'
#alias mks='mk start --memory 8192 --cpus 4 --alsologtostderr --v 3'

# Show local kubeconfig files or copy a KUBECONFIG file to ~/.kube/config
function kch
{
    if [[ "$#" -ne 1 ]]; then
        lla ~/.kube
    else
        cp ~/.kube/"${1}"-config ~/.kube/config
    fi
}

function get_pod_name_by_label
{
    kg po -l "$1" -o custom-columns=NAME:.metadata.name | tail +2 | uniq
}

alias kpn='get_pod_name_by_label'

function switch_k8s_namespace
{
    if [[ "$#" -ne 1 ]]; then
        kg ns
    else
        kc set-context --current --namespace "$1"
    fi
}

alias kn='switch_k8s_namespace'


# Display all the kube-contexts passed as $1 with index. Add (*) for the current context
function show_kube_contexts {
  input=$1
  contexts=(${(f)input})
  curr=$(kcc)
  for (( i = 1; i <= ${#contexts}; i++ )); do
    c=$contexts[$i]
    suffix=''
    if [[ $c == $curr ]]; then
      suffix='(*)'
    fi
    echo "[$i] $c $suffix"
  done
}


# kube_context shows and switches kube contexts
#
# The function reads all the contexts from ~/.kube/config
# If you call it with one argument (a partial context name) it will filter
# and show only the matching contexts
#
# Otherwise it will display the list of all the contexts with an index number.
# The current context is marked with asterisk.
#
# You can switch to new context by typing its single index digit.
# If there are more than Nine contexts you need to press <enter> too.
function switch_kube_context {
  if [[ "$#" == 0 ]]; then
    contexts=$(kcg)
  else
    contexts=$(kcg | rg $1)
  fi

  show_kube_contexts $contexts

  new_context=""
  while [[ $new_context == "" ]]; do
    echo "Choose a context (1..${#contexts}):"
    if (( ${#contexts} < 10 )); then
      read -rs -k 1 answer
    else
      read -r answer
    fi
    # new_context=$contexts[(($answer))]
  done

  kcu $new_context
}

alias kcx=switch_kube_context


# Bash completion for kubectl
#autoload -Uz compinit
#compinit
#source <(kubectl completion zsh)

################################## ..KUBECTL ##################################
source <(kubectl completion bash)
alias k='kubectl '
alias ka='kubectl apply -f '
alias kall='kubectl get po,deploy,statefulset,svc,ingress,pvc'
alias kallw='watch kubectl get po,deploy,statefulset,svc,ingress,pvc'
alias kc='kubectl config get-contexts '
alias kuc='kubectl config use-context '
alias kd='kubectl describe '
alias kroles='kubectl get serviceaccount,role,rolebinding '
alias kdel='kubectl delete -f '
alias kg='kubectl get '
alias kcheckapi='kubectl get apiservice|grep False '
alias kpo='kubectl get pods '
# Get all pods an a specific worker node. Usage: kponode pnv-it-kwsre006
alias kponode=kponode; kponode() {
  kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName="$1"
}
# Get all pod ip addresses in current namespace
alias kips='kubectl get endpoints -o yaml | grep -A 4 ip '
# Get all pod ip addresses in all namespaces
alias kipsall='kubectl get endpoints -A -o yaml | grep -A 4 ip '
# Set current namespace. Usage: kn ingress-nginx
alias kn='kubectl config set-context $(kubectl config current-context)  --namespace  '
alias kgn='kubectl get namespace '
alias krq='kubectl get resourcequotas'
alias ksec='kubectl get secrets,configmap'
alias ksa='kubectl get serviceaccount,role,rolebinding'
alias kcdel='kubectl config delete-context '  
# List all kube config files in kubeconfigs folder
alias kls='ls -la ~/.kube/kubeconfigs '
# Show which kubeconfig file is selected
alias kenv='echo $KUBECONFIG'
# Show current kubeconfig file token
alias ktoken='cat $KUBECONFIG | grep -i "token:"'

# Shortcut for dry-run command. Usage: k run -n mynamespace mydeployment $do --image=nginx
export do='--dry-run -o yaml' # export do='--dry-run=client -o yaml' # You have to set client for kubectl 1.18 and above
# Shortcut for dry-run no restart command. Usage: k run -n mynamespace mydeployment $dor --image=nginx
export dor='--restart=Never --dry-run -o yaml'
# Shortcut for restart never command. Usage: k run -n mynamespace mydeployment $rr --image=nginx
export rn='--restart=Never'
# Shortcut for xclip
export xc='| xclip -sel clip'
# Show what kubectl permissions I have
alias kcani='kubectl auth can-i --list '
# List all Rancher bookmarks
alias kbook='cat ~/.kube/kubeconfigs/cluster_bookmarks.txt'
# Show stats, versions and health checks for cluster
alias kstats='kubectl version --short && kubectl get cs && kubectl get nodes && kubectl cluster-info'
# List all the api versions for cluster
alias kapi='kubectl api-versions'

# ks - Switch to any cluster context using grep
# Copy cluster config files to $HOME/.kube/kubeconfigs with names like:
# cluster-dn8-sp-kcapp001_BeonStable.config
# cluster-dn8-sp-kcapp101_BeonTC.config etc.
# After that these scripts will find them and set one match to the KUBECONFIG env variable
# Usage: kn beonstable
# Changing config to BeonStable_cluster-dn8-sp-kcapp001.config
# KUBECONFIG set: /home/username/.kube/kubeconfigs/BeonStable_cluster-dn8-sp-kcapp001.config
alias ks=ks; ks() {
  grep_count=`ls $HOME/.kube/kubeconfigs | grep -i $1 | wc -l`

  if [[ $grep_count == 1 ]]; then
    config_name=`ls $HOME/.kube/kubeconfigs | grep -i $1`
    echo -e "${GREEN}Changing config to $config_name${NORMAL}"
    export KUBECONFIG=$HOME/.kube/kubeconfigs/$config_name
    echo "KUBECONFIG set: $KUBECONFIG"
  elif [[ $grep_count == 0 ]]; then
    echo -e "${RED}No matches found to: $1${NORMAL}"
  else
    echo -e "${RED}More then one matches found:${NORMAL}"
    ls $HOME/.kube/kubeconfigs | grep -i $1
  fi
}
alias kj=kj; kj() {
  grep_count=`ls $HOME/.kube/jarvis-configs | grep -i $1 | wc -l`

  if [[ $grep_count == 1 ]]; then
    config_name=`ls $HOME/.kube/jarvis-configs | grep -i $1`
    echo -e "${GREEN}Changing config to $config_name${NORMAL}"
    export KUBECONFIG=$HOME/.kube/jarvis-configs/$config_name
    echo "KUBECONFIG set: $KUBECONFIG"
    # kubectl get node
  elif [[ $grep_count == 0 ]]; then
    echo -e "${RED}No matches found to: $1${NORMAL}"
  else
    echo -e "${RED}More then one matches found:${NORMAL}"
    ls $HOME/.kube/jarvis-configs | grep -i $1
  fi
}
alias kconfig="export KUBECONFIG=$HOME/.kube/config"

# Enable auto-completion features 
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    fi
fi

################################## ..KUBECTL2 ##################################
# Copy selected kubeconfig file to ~/.kube/config and set KUBECONFIG for it
# (Reason: Some applications look at the ~/.kube/config file instead of KUBECONFIG env variable)
alias kcopy=kcopy; kcopy() {
  grep_count=`ls $HOME/.kube/kubeconfigs | grep -i $1 | wc -l`

  if [[ $grep_count == 1 ]]; then
    config_name=`ls $HOME/.kube/kubeconfigs | grep -i $1`
    echo -e "${GREEN}Overwriting ~/.kube/config with $config_name${NORMAL}"
    cp $HOME/.kube/kubeconfigs/$config_name $HOME/.kube/config
    export KUBECONFIG=$HOME/.kube/config
  elif [[ $grep_count == 0 ]]; then
    echo -e "${RED}No matches found to: $1${NORMAL}"
  else
    echo -e "${RED}More then one matches found:${NORMAL}"
    ls $HOME/.kube/kubeconfigs | grep -i $1
  fi
}

alias bookmarkrename=bookmarkrename; bookmarkrename() {
  if [[ -f ~/.kube/kubeconfigs/cluster_bookmarks.txt ]] ; then
  mkdir -p ~/.kube/renamed-configs && cd ~/.kube/jarvis-configs && for cluster in $(ls *.config); do printf "${cluster}\t" && result=$(cat ~/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $(echo "${cluster}" | cut -d '.' -f1) | cut -d '_' -f1) && printf "${result}\n" && if [ -n "$result" ]; then cp $cluster ~/.kube/renamed-configs/${result}_${cluster}; fi ; done && cd -
  else
    echo "no ~/.kube/kubeconfigs/cluster_bookmarks.txt found."
    echo "Please import Cluster bookmarks from ~/repos/msci-tools/bookmark and run ~/repos/msci-tools/chrome_bookmakrs/create_bookmarks_txt.py"
  fi
}
# Open rancher ui in Chrome Browser using grep
# You need: sudo apt-get install --reinstall xdg-utils in wsl
# You also need to make a symlink pointing to Windows Chrome
# /bin/ln -s "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" ~/.local/bin/chrome
# or
# /bin/ln -s "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$HOME/.local/bin/chrome"
alias ko=ko; ko() {
  echo "Reading urls from: $HOME/.kube/kubeconfigs/cluster_bookmarks.txt"
  grep_count=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1 | wc -l`
  if [[ $grep_count == 1 ]]; then
    url_name=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1 | cut -d '#' -f1`
    echo -e "${GREEN}Opening in Chrome browser $url_name${NORMAL}"
    xdg-open `cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1 | cut -d '#' -f2`
  elif [[ $grep_count == 0 ]]; then
    echo -e "${RED}No matches found to: $1${NORMAL}"
  else
    echo -e "${RED}More then one matches found:${NORMAL}"
    cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1
  fi
}
# open all grep
alias koa=koa; koa() {
  echo "Reading urls from: $HOME/.kube/kubeconfigs/cluster_bookmarks.txt"
  for i in `cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1`; do
    url_name=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $i | cut -d '#' -f1`
    url=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $i | cut -d '#' -f2`
    echo -e "${GREEN}Opening in Chrome browser $url_name${NORMAL}";
    xdg-open $url
  done
}
# open all grep
alias koam=koam; koam() {
  for i in `cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $1`; do
    url_name=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $i | cut -d '#' -f1`
    url=`cat $HOME/.kube/kubeconfigs/cluster_bookmarks.txt | grep -i $i | cut -d '#' -f2`
    # echo $url
    url="${url}/security/members"
    echo -e "${GREEN}Opening in Chrome browser $url_name${NORMAL}";
    echo -e "${BLUE}${url}${NORMAL}"
    xdg-open $url
  done
}
# alias kex=kex; kex () {
alias kex=kex; kex () {
  kubectl exec -it $1 -- /bin/sh
}
## kubectl exec alias with grep
alias kexg=kexg; kexg () {
  grep_count=`kubectl get pods --no-headers=true | grep -i $1 | wc -l`

  if [[ $grep_count == 1 ]]; then
    pod_name=`kubectl get pods --no-headers=true | grep -i $1 | cut -d' ' -f 1`
    echo -e "${GREEN}Entering shell for $pod_name${NORMAL}"
    kubectl exec -it $pod_name -- /bin/sh
  elif [[ $grep_count == 0 ]]; then
    echo -e "${RED}No matches found to: $1${NORMAL}"
  else
    echo -e "${RED}More then one matches found:${NORMAL}"
    kubectl get pods --no-headers=true | grep -i $1
  fi
}

# copy extended cleanup to node
alias extended=extended; extended() {
  scp -i ~/.ssh/rancher_id_rsa extended_cleanup.sh "rancher@$1.mgmt.msci.org:/home/rancher" \
  && ssh -i ~/.ssh/rancher_id_rsa rancher@$1.mgmt.msci.org
}
# ssh into a kubernetes rancher node using just the node name, working from Global Protect VPN Desktop
alias kssh=kssh; kssh() {
  ssh -o LogLevel=error -i ~/.ssh/rancher_id_rsa rancher@$1.mgmt.msci.org $2
}
alias ksshcc=ksshcc; ksshcc() {
  ssh -o LogLevel=error -i ~/.ssh/rancher_id_rsa rancher@$1.ccmgmt.msci.com $2
}
alias ksship=ksship; ksship() {
  ssh -o LogLevel=error -i ~/.ssh/rancher_id_rsa rancher@$1
}
alias acrcheck='kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c'
# grep or: grep 'pattern1\|pattern2' filename
# kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c | grep 'mscipmritbase01cr.azurecr.io\|mscipmrittp01cr.azurecr.io'
# kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c | grep 'pnv-it-lreg0001.mgmt.msci.org\|mscipmrittp01cr.azurecr.io'
alias swiss="echo 'kubectl run -it --rm swiss-testpod1 --image=pnv-it-lreg0001.mgmt.msci.org:4443/leodotcloud/swiss-army-knife:latest --command /bin/bash'"
# https_proxy=http://ctnproxy-us.int.msci.com:8080 wget https://cnn.com
# https_proxy=http://geoproxy.geo.msci.org:8080 wget https://cnn.com

###############################################################################