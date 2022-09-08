alias setproxy='export HTTP_PROXY=webproxy.sc.intra:8080 \
&& export http_proxy=webproxy.sc.intra:8080 \
&& export https_proxy=webproxy.sc.intra:8080 \
&& export HTTPS_PROXY=webproxy.sc.intra:8080 \
&& export HTTPS_PROXY=webproxy.sc.intra:8080 \
&& export NO_PROXY=**.nop.sc.intra|*.sc.intra|localhost|127.0.0.1'

alias unsetproxy='unset http_proxy && unset https_proxy && unset no_proxy && unset HTTP_PROXY && unset HTTPS_PROXY && unset NO_PROXY'
alias showproxy='echo http_proxy: $http_proxy && echo https_proxy: $https_proxy && echo no_proxy: $no_proxy && echo HTTP_PROXY: $HTTP_PROXY && echo HTTPS_PROXY: $HTTPS_PROXY && echo NO_PROXY: $NO_PROXY'

alias set_java_proxy='export JAVA_OPTS=-Dhttps.proxyHost=webproxy.sc.intra -Dhttps.proxyPort=9090 -Dhttp.proxyHost=webproxy.sc.intra -Dhttp.proxyPort=9090 -DnonProxyHosts="*.nop.sc.intra|*.sc.intra|localhost|127.0.0.1"'
alias unset_java_proxy="unset JAVA_OPTS"
    

################################ ..INSTALL #####################################
# Command to install binary tools on servers using proxy or not
  if [[ $USER == "$admin_username" ]]; then
    export USEPROXY='https_proxy=http://webproxy.sc.intra:8080'
    alias tfinit="$USEPROXY terraform init --upgrade"
  else
    export USEPROXY='echo "(proxy not used)" && '
  fi

