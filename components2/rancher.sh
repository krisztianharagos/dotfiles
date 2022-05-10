############################### ..RANCHER ###############################
alias ra='rancher'
alias ralist='rancher cluster ls'
alias rac='rancher context current'
alias ras='rancher context switch'
# You can get the Bearer token from kvau-die1-sr-nonprod001 keyvault
alias ralogin='rancher login https://cc-n4.msciapps.com/v3 --token $(cat ~/.kube/.rabear)'
alias rajarvis='rancher login https://cc-n4.msciapps.com/v3 --token $(cat ~/.kube/.jarvis-admin)'
# path: ~/.rancher/cli2.json

# You need rancher login first to download configs
alias getrancherconfigs=getrancherconfigs; getrancherconfigs() {
  mkdir -p ~/.kube/kubeconfigs && for cluster in $(rancher cluster ls --format {{.Cluster.Name}}); do rancher cluster kubeconfig "$cluster" > ~/.kube/kubeconfigs/$cluster.config; done
}
