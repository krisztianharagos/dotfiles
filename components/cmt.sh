export CMT_HOME="/Users/krisztian.haragos/cmt"
export CMT_USER=kharagos

export AWS_PROFILE=dev-user

# cmtaws sso login
# $(cmtaws codeartifact read)
# echo $CODEARTIFACT_AUTH_TOKEN

function cmtl () {
  cmtaws sso login
  $(cmtaws codeartifact read)
}


