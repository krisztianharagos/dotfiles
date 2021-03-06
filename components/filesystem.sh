################################# ..FILESYSTEM #################################
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;35:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
alias ll="ls -laFh  --show-control-chars -F --color "
# List file with grep. Usage:
# $ lg beon
# -rw-------. 1 username M_DRAG_Linux_Users  16K Sep  8 11:35 BeonFWK_cluster-dn8-sp-kcbfwk01.config
# -rw-------. 1 username M_DRAG_Linux_Users  16K Sep  8 11:37 BeonProd_cluster-pnv-sp-kcapp001.config
# -rw-------. 1 username M_DRAG_Linux_Users  16K Nov 24 18:03 BeonStable_cluster-dn8-sp-kcapp001.config
alias lg="ls -laFh  --show-control-chars -F --color | grep -i "
# List all aliases and filter them with grep. Usage: aliasg kube
alias alg="alias | grep -i "
alias la="ls -Ah  --show-control-chars -F --color "
# alias lt="echo 'Showing first 10 results:' && ls -lacth  --show-control-chars -F --color | head -n 11"
alias lsn="stat -c '%a %A %U %G %s %n' *"


alias ll="ls -lhArt"
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"
alias ps="ps aux"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias wget="wget -c"
alias histg="history | grep"
alias top="htop"
alias myip="curl -s http://ipecho.net/plain; echo"



alias cu='cd /c/workspace/ui/graph'
alias cdo='cd /c/workspace/devops'
alias cdb='cd /c/workspace/devops/beon-devops-dashboard'
alias cdu='cd /c/workspace/ui/graph'
alias cdp='cd /Users/harakri/projects'
alias cw='cd /c/work'

