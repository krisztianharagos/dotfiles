function mcd () {
    mkdir -p $1
    cd $1
}

function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep "DNS After")
}

function jwt () {
  cut -d"." -f1,2 <<< $1 | sed 's/\./\n/g' | base64 --decode | jq
}

function sshkeygen () {
  cp -rf ~/.ssh ~/.ssh.$(date --utc +%Y%m%d_%H%M%SZ).bak
  ssh-keygen -t rsa -b 4096 -N "hariVeryStrongSecret123!ekr" -C "KrisztianMatyas.Haragos@msci.com" -q -f  ~/.ssh/id_rsa
  cp ~/.ssh/id_rsa* .
}

