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

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

alias capcb='pbcopy.exe'
alias retcb='pbpaste.exe'