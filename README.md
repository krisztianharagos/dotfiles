# dotfiles


adduser harakri
usermod -aG sudo harakri


git clone https://github.com/krisztianharagos/dotfiles

vi /etc/wsl.conf
# see etc-wsl.conf

wsl --shutdown

vi ~/.bashrc
. ~/.bashrc
# append bashrc-append.sh

ln -s /c/Users/harakri/.kube/ ~/.kube
