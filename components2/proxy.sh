alias setproxy='export HTTP_PROXY=geoproxy.geo.msci.org:8080 \
&& export http_proxy=geoproxy.geo.msci.org:8080 \
&& export https_proxy=geoproxy.geo.msci.org:8080 \
&& export HTTPS_PROXY=geoproxy.geo.msci.org:8080 \
&& export HTTPS_PROXY=geoproxy.geo.msci.org:8080 \

&& export NO_PROXY=*.msci.org,*.msci.com,*.msciapps.com'
alias unsetproxy='unset http_proxy && unset https_proxy && unset no_proxy && unset HTTP_PROXY && unset HTTPS_PROXY && unset NO_PROXY'
alias showproxy='echo http_proxy: $http_proxy && echo https_proxy: $https_proxy && echo no_proxy: $no_proxy && echo HTTP_PROXY: $HTTP_PROXY && echo HTTPS_PROXY: $HTTPS_PROXY && echo NO_PROXY: $NO_PROXY'

################################ ..INSTALL #####################################
# Command to install binary tools on servers using proxy or not
  if [[ $USER == "$admin_username" ]]; then
    export USEPROXY='https_proxy=http://geoproxy.geo.msci.org:8080'
    alias tfinit="$USEPROXY terraform init --upgrade"
  else
    export USEPROXY='echo "(proxy not used)" && '
  fi

