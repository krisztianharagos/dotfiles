export GIT_HOME=~/git

alias g='git'
alias gci='git commit -a'
alias gcia='git commit -a --amend'
alias gb='git branch'
alias gbd='git branch -D'
alias gbc='git branch --show-current | pbcopy'
alias gru='git config --get remote.origin.url | pbcopy'
alias gco='git checkout'
alias gpu='git pull --rebase'
alias gg='git grep -i'
alias gs='git status -uno'
alias gd='git diff'
alias gl='git log --oneline'


# Show all untracked files and directories in current dir
alias gu='git clean -n -d .'

# Clean all untracked files and directories under current dir
alias gx='git clean -f -d'

# Create remote git branch (and local too) from master
function git_create_remote_branch() {
  gco master
  gpu
  gb $1
  g push -u origin $1
  gco $1
}
alias gcrb='git_create_remote_branch'

# Push current branch to remote (bail out of on master)
function git_push_remote_branch() {
  curr=$(git branch --show-current)
  if [[ "$curr" -eq "master" ]]; then
    echo "You're on master. Switch to another branch"
    return 1
  fi

  gs -u | grep 'nothing to commit, working tree clean'
  if [ $? -ne 0 ]; then
    "Working tree is not clean"
  fi

  g push origin "$curr"
}
alias gprb='git_push_remote_branch'

# Rebase the current branch on master
function git_rebase_on_master() {
  curr=$(git branch --show-current)
  gco master
  gpu
  gco $curr
  g rebase master
}
alias grom='git_rebase_on_master'

# Check if git repo has changed changed (master vs. origin/master)
function git_has_repo_changed() {
  pushd . > /dev/null
  cd "$1" > /dev/null || exit 2
  modified=$(git remote -v update 2>&1 | grep master | grep -v "up to date")
  popd > /dev/null || exit 2
  if [[ "$modified" -eq '' ]]; then
    return 1 # False
  else
    return 0 # True
  fi
}

################################# ..GIT #################################
alias ga='git add '
alias gac='git add . && git commit '
alias gbr='git branch '
alias gbrall='git branch -a '
alias gc='git commit '
alias gcm='git commit -m'
alias gch='git checkout '
alias gremote='git remote -v'

# Commit and push file changes, show files to commit and approve if ready to push:
alias gpushc=gapushc; gapushc() {
  if [ "$1" = "" ]; then
    echo "Please give a commit message like: gpushc 'commit message here', sleeping for 30 sec..." && sleep 30
  else
    echo "commit message: $1"
  fi
  git status; read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1 \
  && git add -A && git commit -m "$1" && git push origin `git rev-parse --abbrev-ref HEAD`
  echo $1
}

# Save git passwords to system memory and cache it for 9000 seconds (2.5 hours)
alias gcred="git config --global credential.helper 'cache --timeout=9000'"
alias gbrc='git checkout -b '
alias gchm='git checkout master 2> /dev/null || git checkout main 2> /dev/null'
alias gcl='git clone'
alias grc='git rebase --continue'
alias gclean='git clean -fdx'
alias gunstage='git rm --cached -rf .'
alias guser='git shortlog -s -n --all --no-merges'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch -v && git status'
alias ghead='git checkout -B master HEAD'
alias gi='git add --interactive'
alias gl="git log --pretty='%C(Yellow)%H  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s' -20"
alias glall='git log --oneline --all --graph --decorate'
alias gpop='git stash pop'
alias gmerge='git checkout master && git pull && git merge develop && git push && git checkout develop'
alias gpull='git pull origin `git rev-parse --abbrev-ref HEAD`'
alias gpullf='git reset --hard HEAD && git clean -fdx && git pull origin `git rev-parse --abbrev-ref HEAD`'
alias gpush='git push origin `git rev-parse --abbrev-ref HEAD`'
alias gtrack='git branch --set-upstream-to=origin/`git rev-parse --abbrev-ref HEAD`'
alias grhard='git reset HEAD^ --hard'
alias grsoft='git reset HEAD^ --soft'
alias gs='git status -s'
alias gsort='git log HEAD --pretty="/invert:%h" --name-only | grep -v -E \
"^\/invert:|^$" | sort -u | while read path; \
do echo $(git log -1 --pretty="%ad %h" --date=format:"%Y-%m-%d %H:%M:%S" -- "$path") $path;done | sort -u'
alias gshow='git fetch --all && git remote show origin'
alias gst='git status'
alias gstash='git stash'
alias getsshkey='cat ~/.ssh/id_rsa.pub | xclip -sel clip \
&& echo "copied, if not run ssh-keygen -b 4096"'
alias gsize=gsize; gsize() {
git status --porcelain | sed 's/^...//;s/^"//;s/"$//' | while read path; do
    du -bs "$path" ;
done | sort -n | awk ' {tot = tot+$1; print } END { printf("%.2fMB\n",tot/(1024*1024)) }'
}