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
  ssh-keygen -t rsa -b 4096 -N "hariVeryStrongSecret123!ekr" -C "kharagos@cmtelematics.com" -q -f  ~/.ssh/id_rsa
  cp ~/.ssh/id_rsa* .
}

# https://stackoverflow.com/questions/24283097/reusing-output-from-last-command-in-bash
# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

viret () { code /tmp/capture.out; }

alias cap2='pbcopy.exe'
alias ret2='pbpaste.exe'
