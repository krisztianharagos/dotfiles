# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# eval "$(pyenv init --path)"

# export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"

export PIP_REQUIRE_VIRTUALENV=false
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_CACHE_DIR="/Users/krisztian.haragos/cmt/pipenv_cache"

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

function python_pipenv_install() {
  PIPENV_VERBOSITY=-1 PIPENV_VENV_IN_PROJECT=1 pipenv install
}

function python_poetry_activate() {
  source`poetry env info --path`/bin/activate
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
    pushd $(realpath $d)

    python_poetry_install

    popd
  done
}

function python_requirements_install_projects() {
  for d in `find . -type f -name 'requirements.txt' | sed -r 's|/[^/]+$||' |sort |uniq`:
  do
    pushd $(realpath $d)

    pip install -r requirements.txt --prefer-binary -q

    popd
  done
}

function python_init_requirements_base() {
  pyvenv
  python_requirements_install_projects
}

function flask_run() {
  python -m flask run
}

function python37 () {
  pyenv global 3.7.13
  pyenv versions
}

function python38 () {
  pyenv global 3.8.13
  pyenv versions
}

function python36 () {
  pyenv global 3.6.15
  pyenv versions
}

alias flask='flask_run'

alias pyreqinit='python_init_requirements_base'

alias pyvenv='pyton_new_virtual_env'

alias pyactivate='source .venv/bin/activate'

alias pydeactivate='deactivate'

alias pypoinstall='python_poetry_install_and_activate'
alias pypoactivate='python_poetry_activate'

alias pyinstall="pip install -r $1"

# eval "$(register-python-argcomplete pipx)"

# sets global config so that the virtualenvs are created without running
# python -m venv .venv && source .venv/bin/activate
# poetry config virtualenvs.in-project true

#export PATH="$PATH:$HOME/.pyenv/versions/anaconda3-2021.11/bin"
