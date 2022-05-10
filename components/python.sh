eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# eval "$(pyenv init --path)"

export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"

# Create remote git branch (and local too) from master
function pyton_new_virtual_env() {
  python -m venv .venv
  source .venv/bin/activate
}
alias pyvenv='python_new_virtual_env'

alias pyactivate='source .venv/bin/activate'

alias pydeactivate='deactivate'

alias pypoinstall='poetry install'

alias pyinstall='pip install -r $0'

# sets global config so that the virtualenvs are created without running
# python -m venv .venv && source .venv/bin/activate
# poetry config virtualenvs.in-project true

#export PATH="$PATH:$HOME/.pyenv/versions/anaconda3-2021.11/bin"
