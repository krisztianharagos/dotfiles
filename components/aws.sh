# export AWS_DEFAULT_PROFILE=tm-dev
export AWS_PAGER=""
# export AWS_PAGER="less"
# export AWS_PAGER="cat"
export AWS_REGION=us-east-1


complete -C '/usr/local/bin/aws_completer' aws
# /usr/local/bin/aws_completer
export PATH=/usr/local/bin:$PATH

