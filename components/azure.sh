################################### ..AZURE ###################################
# https://github.com/ferhaty/azure-cli-cheatsheet
# To get more verbosity add: --debug
alias azlogin='https_proxy=http://geoproxy.geo.msci.org:8080 az login --debug'
alias azloginj="az login -u ${email_address}"
alias azpim='az role assignment list --assignee krisztianmatyas.haragos@msci.com -otable'
alias azsand='az account set --subscription "1e8b3504-93d8-422d-b5a3-3b3a3aa48ab3"; az account show ' # LinuxEngineering_Sandbox
alias azsre='az account set --subscription "bc5d1df7-4367-461d-9e45-d69bd2f5ecd4"; az account show ' # SRE_Non-Prod
alias azshared='az account set --subscription "221bdae4-bea8-48fa-ba10-c2ccb18f7e08"; az account show ' # SharedServices_Non-Prod
alias azcarbnon='az account set --subscription "96d79e1a-ba57-4419-a349-762c217145e3"; az account show ' # CarbonDelta_Non-Prod
alias azesgprod='az account set --subscription "d289a07a-7c33-4fcc-9e84-667488b0cf99"; az account show ' # ESG_Prod
alias azesgnon='az account set --subscription "9e4e50cf-5a4a-4deb-a466-9086cd9e365b"; az account show ' # ESG_Non-Prod
alias azacr='echo "az acr login  --name cregdva2spbeonacr001"'

if [ -f "$HOME/bin/azure-cli/az.completion" ]; then
  source "$HOME/bin/azure-cli/az.completion"
fi

alias azshow='az account show '
alias azaclist='az account list --all -o table '
alias azakslist='az aks list -o table'
alias azclear='az account clear'
alias azkeylist='az keyvault list -o table'
alias azloc='az account list-locations -o table'
alias azlock='az account lock '
alias azloclist='az account list-locations'
alias azmg='az account management-group '
alias azsetsub='az account set --subscription '
alias azsub='az account set --subscription '
alias aztoken='az account get-access-token'
alias kubeclean='> ~/.kube/config'
# Get AKS token. Usage: azaksget resourcegroup_here aks_name_here
# $ azaksget die1itsre004 akse-die1-it-sre004
# Merged "akse-die1-it-sre004" as current context in /home/username_here/.kube/config
alias azaksget=azaksget; azaksget() {
  if [ "$1" = "" ]; then
    echo "Please provide parameters, i.e: azaksget <resource-group-name> <aks-cluster-name>"
  else
    echo "Overwriting config and creating backup of ~/.kube/config as ~/.kube/config.backup"
    cp ~/.kube/config ~/.kube/config.backup.`date +'%Y-%m-%d_%H%M%S'`
    > ~/.kube/config && az aks get-credentials --resource-group $1 --name $2
    export KUBECONFIG=$HOME/.kube/config
  fi
}


################################### ..PR ###################################

function pro() {
  local prId="$1";
  if [[ ! $prId =~ ^[0-9]+$ ]]; then
  prId="$(az repos pr list --creator KrisztianMatyas.Haragos@msci.com --output tsv --query "[].pullRequestId")";
  fi;
  az repos pr show --id $prId --open --output none
}

function myprs () {
  az repos pr list --project analytics-solution-management --status active --query "[?createdBy.uniqueName=='$(az account show --query "user.name" -o tsv)'].{repo:repository.name, title:title, id: pullRequestId}" | jq -r '.[] | .repo + "\t" + .title + "\thttps://dev.azure.com/msci-otw/analytics-solution-management/_git/" + .repo + "/pullrequest/" + (.id | tostring)'
}

function pl() {
  "C:\Program Files\Google\Chrome\Application\chrome.exe"  "https://dev.azure.com/msci-otw/analytics-solution-management/_build?definitionScope=%5C$(basename `git rev-parse --show-toplevel`)"
}

agent-ssh ()
{
  local ip=`az vmss nic list -g rgrp-dva2-so-ado-agents --vmss-name ssdva2soadoal01 | jq -r ".[].ipConfigurations[].privateIpAddress" | head -n 1`;
  ssh $ip
}

function azagent() {
  AZ_RG_AGENTS='--resource-group RGRP-DVA2-SP-ADO-AGENTS'
  AZ_VMSS_AGENTS='--name ssdva2spadoagent'
  ssh $(az vmss nic list $AZ_RG_AGENTS  ${AZ_VMSS_AGENTS/--/--vmss-}-$1 | jq '.[0].ipConfigurations[].privateIpAddress' | tr -d \")
}

function azpersonal() {
  AZ_RG='--resource-group rgrp-dva2-sp-personal-harakri'
  AZ_VM='--name dva2spharakri01'
  ssh $(az vmss nic list $AZ_RG  ${AZ_VM/--/--vmss-}-$1 | jq '.[0].ipConfigurations[].privateIpAddress' | tr -d \")
}

function agent-ssh() {
  local ip=`az vmss nic list -g rgrp-dva2-so-ado-agents --vmss-name ssdva2soadoal03 | jq -r ".[].ipConfigurations[].privateIpAddress" | head -n 1`;
  ssh $ip -l azureadmin
}
