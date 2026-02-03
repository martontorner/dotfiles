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
