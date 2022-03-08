################################### ..POSTGRES ####################################
# systemctl status postgresql or service postgresql status
# ps --no-headers -o comm 1
# systemd - select the systemd (systemctl) tab below.
# init - select the System V Init (service) tab below.
# \l

alias poclusters='pg_lsclusters'
alias poconfig='sudo vim /etc/postgresql/*/main/postgresql.conf'
alias pocreatedb='sudo -u postgres bash -c "psql -c \"CREATE DATABASE jarvis_db\""'
alias pocs='sudo pg_ctlcluster 9.5 main start'
alias podb='sudo -u postgres bash -c "psql -c \"SHOW data_directory;\""'
alias poexit='\q'
alias pohba='sudo vim /etc/postgresql/*/main/pg_hba.conf'
alias polist='sudo -u postgres bash -c "psql -c \"\l\""'
alias porestart='sudo service postgresql restart'
alias poshell='sudo -u postgres psql'
alias postart='sudo service postgresql start'
alias postatus='sudo service postgresql status'
alias postop='sudo service postgresql stop'
alias potables='sudo psql -a -U postgres -p 5432 -h localhost -c "\dt" jarvis_db'
