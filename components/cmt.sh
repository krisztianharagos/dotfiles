export CMT_HOME="/Users/krisztian.haragos/cmt"
export CMT_USER=kharagos

export AWS_PROFILE=dev-user

# cmtaws sso login
# $(cmtaws codeartifact read)
# echo $CODEARTIFACT_AUTH_TOKEN

function cmtl () {
  cmtaws sso login
  $(cmtaws codeartifact read)
  cmtaws ec2 sshsetup
}

# see dotfiles
# function sshs() {
#     ssh $@ "cat > /tmp/.bashrc_kharagos" < /Users/krisztian.haragos/cmt/personal_kharagos/home_resources/.bashrc_remote.sh
#     ssh $@ "cat > /tmp/kharagos_check.py" < /Users/krisztian.haragos/cmt/personal_kharagos/notebook/kharagos_check.py
#     ssh -t $@ "bash --rcfile /tmp/.bashrc_kharagos ; rm /tmp/.bashrc_kharagos ; cd /tmp"
# }

function cmtsshutil() {
  # cmtaws ec2 -r us-east-1 -n cmt-alpha-utility -e ssh
  UTIL=cmt-alpha-utility.us-east-1.dev-user.cmtaws
  sshs $UTIL
}

function cmtdockercompose() {
  echo "stuff"
}
