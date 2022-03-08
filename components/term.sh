################################## ..SCREEN ##################################
# Changes screen windows title names to which folder you are in 
# Like:  1$* ~  2$ bin  3-$ certs  4$ tmp  5$ .kube  
if [[ "$TERM" == screen* ]]; then
  screen_set_window_title () {
    local HPWD="$PWD"
    case $HPWD in
      $HOME) HPWD="~";;
      $HOME/*) HPWD="~${HPWD#$HOME}";;
    esac
    # only last directory
    printf '\ek%s\e\\' "${HPWD/*\//}"
    # full path
    # printf '\ek%s\e\\' "$HPWD"
  }
  PROMPT_COMMAND="screen_set_window_title; $PROMPT_COMMAND"
fi


################################### ..COLORS ###################################
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# palette: https://misc.flogisoft.com/bash/tip_colors_and_formatting
NORMAL='\033[1;00m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
LCYAN='\033[1;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
PURPLE='\033[1;31m'
ORANGE='\033[0;94m'
LORANGE='\033[1;33m'
GRAY='\033[0;90m'
LGRAY='\033[1;90m'

################################## ..EXTRACT ###################################
# Extract any compressed file. Autometically finds out the right command from the file extension:
# Usage: extract mycompressedfile.tar.gz
extract () {
  if [[ -f $1 ]] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

################################# ..DIRECTORIES #################################
# Navigate to .kube folder
alias kube='cd ~/.kube'
# Navigate to .kube/kubeconfigs folder
alias kubek='cd ~/.kube/kubeconfigs'
# Navigate to Downloads folder
alias dow='cd ~/Downloads'
# Copy current path to clipboard
alias pwdc="pwd | tr -d '\n' | xclip -sel clip"
# Sort and list all files and folders by size
alias dua='du -sch .[!.]* * |sort -h' 
# Enable cd.. and cd~ usage without space
alias cd..='cd ..'
alias cd~='cd ~'

################################# ..SCREEN, TMUX #################################
# Start GNU screen session named screen1 or attach to it if already exists
alias screen1='screen -d -r screen1 || screen -S screen1'
# Start GNU screen session named screen2 or attach to it if already exists
alias screen2='screen -d -r screen2 || screen -S screen2'
# Kill screen1
alias screen1kill='screen -X -S screen1 quit'
# Kill screen2
alias screen2kill='screen -X -S screen2 quit'
# Start tmux session named tmux1 or attach to it if already exists
alias tmux1='tmux new -A -s tmux1'
# Kill tmux session
alias tkill='tmux kill-session -t '

################################ ..COMPLETION ###############################
# Autocompletion for kubectl -> tab tab

# kubectl autocompletion
if [[ -n "$BASH" ]] && [[ -x "$(command -v kubectl)" ]] && [[ -f ~/.kube/config ]]; then
  if [[ -x "$(command -v kubectl)" ]]; then
      source <(kubectl completion bash)
      complete -F __start_kubectl k
  fi
# Bash autocompletion
  if ! shopt -oq posix; then
    if [[ -f /etc/profile.d/bash_completion.sh ]]; then
      source /etc/profile.d/bash_completion.sh
    fi
  fi
fi

################################### ..PS1 ###################################

# Get current time and show it in PS1 like: 11:29:02
function __get_time_ps1() {
    TIME=$(date +"%H:%M:%S")
    if [[ -n "$TIME" ]]; then
        echo "${TIME}"
    fi
    }

# Get current cluster and namespace names like: {mfdc:cluster-dn8-sp-kcapp001:ingress-nginx}
function __k8s_details_ps1() {
    # Get current context and namespace if set
    if [[ -x "$(command -v kubectl)" ]] && [[ -f ~/.kube/config ]] && [[ -f "$KUBECONFIG" ]]; then
        CONTEXT=$(kubectl config current-context)
        NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')
        if [[ -n "$CONTEXT" ]]; then
            K8S_DETAILS="${CONTEXT}"
            if [[ -n "$NAMESPACE" ]]; then
            K8S_DETAILS="${CONTEXT}:${NAMESPACE}"
            fi
        fi
        if [[ -n "$K8S_DETAILS" ]]; then
            echo "${K8S_DETAILS}"
        fi
    else
      echo "_"
    fi
}

# Get current git branch name like: (pa-scheduler)
function git_details_ps1() {
    # Get current git branch
    if [[ -x $(command -v git) ]]; then
      GIT_BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    else
      echo "Please install git with sudo apt install -y git"
    fi
    if [[ -n "$GIT_BRANCH" ]]; then
        echo "${GIT_BRANCH}"
    fi
}
# Get current git branch status like: (master)+
function markup_git_branch() {
  if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
    echo -e ""
  else
    # Show + sign if there are uncommitted changes in current git branch
    echo -e "+"
  fi
}
# Get current kubeconfig token name like: {09c:crc-uat:qgis}
function get_k8s_token() {
    if [[ -n "$KUBECONFIG" ]] && [[ -f "$KUBECONFIG" ]]; then
      # Check if kubeconfig is a Rancher style kubeconfig file:
      is_rancher_token=$(cat $KUBECONFIG | grep -i "kubeconfig-u-" | wc -l)
      if [[ $is_rancher_token == 1 ]]; then
        cat $KUBECONFIG | grep -i "kubeconfig-u-" | cut -d '-' -f 3 | grep -Po "^..."
      else
        if [[ -x $(command -v md5sum) ]]; then
          cat $KUBECONFIG | grep -i "token: " | md5sum | head -c 3
        fi
      fi
    else
      echo "_"
    fi
}

# Get current kubeconfig token name like: {09c:crc-uat:qgis}
function get_az_subscripion_id() {
    if [[ -x $(command -v az) ]]; then
      token_last_3_digit=$(az account show | grep "id" | cut -d ':' -f2 | egrep -Eio '.{3,5}$' | head -c 3)
      echo $token_last_3_digit
    else
      echo "_"
    fi
}

# Indicate if proxy is enabled with a ! symbol in PS1 like: 07:44:57 ! username_here
function is_proxy_enabled() {
    if [[ -n "$HTTP_PROXY" ]]; then
      echo " !"
    fi
}


# Set custom PS1
# Current look:
#    time  proxy   user    hostname    token current cluster  current namespace git branch  current folder
# 15:35:22 ! user_name dn8-it-lchtst07 {jjt:cluster-dn8-sp-kcapp101:default} (git-branch) /tmp ▼
if [[ -n "$BASH" ]] ;then
  export PS1="${NORMAL}\$(declare -F __get_time_ps1 >/dev/null && __get_time_ps1)${RED}\$(is_proxy_enabled) \u ${GREEN}\h${YELLOW} {\$(get_az_subscripion_id):\$(declare -F __k8s_details_ps1 >/dev/null && __k8s_details_ps1)}${BLUE} \$(declare -F git_details_ps1 >/dev/null && git_details_ps1)\$(markup_git_branch)${CYAN} \w${NORMAL} >\n\$ "
  # export PS1="${NORMAL}\$(declare -F __get_time_ps1 >/dev/null && __get_time_ps1)${RED}\$(is_proxy_enabled) \u ${GREEN}\h${YELLOW} {\$(get_k8s_token):\$(declare -F __k8s_details_ps1 >/dev/null && __k8s_details_ps1)}${BLUE} \$(declare -F git_details_ps1 >/dev/null && git_details_ps1) ${CYAN} \w${NORMAL} >\n\$ "
  # export PS1="${NORMAL}${RED} \u ${GREEN}\h${YELLOW} {:}${BLUE})${CYAN} \w${NORMAL} ▼\n\$ "

fi