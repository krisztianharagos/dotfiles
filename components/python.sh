eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# eval "$(pyenv init --path)"

export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"

export PIP_REQUIRE_VIRTUALENV=false

# Create remote git branch (and local too) from master
function pyton_new_virtual_env() {
  python -m venv .venv
  source .venv/bin/activate
}

function python_poetry_install() {
  poetry env use 3.8.13
  #poetry env info
  poetry install
}

function python_poetry_activate() {
  source $(poetry env info --path)/bin/activate
}

function python_poetry_install_and_activate() {
  python_poetry_install
  python_poetry_activate
}

function python_poetry_install_projects() {
  for d in `find . -type f -name 'pyproject.toml' | sed -r 's|/[^/]+$||' |sort |uniq`:
  do
    pushd $d

    python_poetry_install

    popd
  done
}

alias pyvenv='pyton_new_virtual_env'

alias pyactivate='source .venv/bin/activate'

alias pydeactivate='deactivate'

alias pypoinstall='python_poetry_install_and_activate'

alias pyinstall='pip install -r $0'

# sets global config so that the virtualenvs are created without running
# python -m venv .venv && source .venv/bin/activate
# poetry config virtualenvs.in-project true

#export PATH="$PATH:$HOME/.pyenv/versions/anaconda3-2021.11/bin"
