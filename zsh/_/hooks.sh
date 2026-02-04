# https://github.com/nvm-sh/nvm#zsh
function chpwd-load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_version
    nvmrc_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_version" != "$(nvm version)" ]; then
      nvm use --silent
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use default --silent
  fi
}
add-zsh-hook chpwd chpwd-load-nvmrc
chpwd-load-nvmrc

function chpwd-load-venv() {
  local venv_path
  venv_path="$(venv_find_dotvenv)"

  if [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" != "$venv_path" ]]; then
    deactivate 2>/dev/null || true
  fi

  if [[ -n "$venv_path" && -f "$venv_path/bin/activate" && "$VIRTUAL_ENV" != "$venv_path" ]]; then
    source "$venv_path/bin/activate"
  fi
}
add-zsh-hook chpwd chpwd-load-venv
chpwd-load-venv
