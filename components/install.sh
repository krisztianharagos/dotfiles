export PATH=~/bin:$PATH
### kubectl 1.18.5
alias installkubectl="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/v1.18.5/bin/linux/amd64/kubectl && chmod 755 kubectl && cd -"
### ranchercli 2.4.10
alias installrancher="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -Lo rancher-linux-amd64-v2.4.10.tar.gz https://github.com/rancher/cli/releases/download/v2.4.10/rancher-linux-amd64-v2.4.10.tar.gz && tar -xzvf rancher-linux-amd64-v2.4.10.tar.gz && cp ./rancher-v2.4.10/rancher rancher && chmod 755 rancher && cd -"
### azure latest
alias installazure="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -L https://aka.ms/InstallAzureCli | bash"
### skaffold 1.15
alias installskaffold="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/v1.15.0/skaffold-linux-amd64 && chmod +x skaffold && cd -"
### helm 3.3.4
alias installhelm="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -Lo helm-v3.3.4-linux-amd64.tar.gz https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz && tar -xzvf helm-v3.3.4-linux-amd64.tar.gz && chmod +x ./linux-amd64/helm && mv ./linux-amd64/helm ${HOME}/bin/ && cd -"
### terraform 0.12.26
alias installterraform="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -Lo terraform_0.12.26.zip https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip && unzip terraform_0.12.26.zip && chmod +x terraform && cd -"
### argocd 1.7.4
alias installargocd="mkdir -p ${HOME}/bin/ && cd ${HOME}/bin/ && curl -Lo argocd https://github.com/argoproj/argo-cd/releases/download/v1.7.4/argocd-linux-amd64 && chmod +x argocd && cd -"
