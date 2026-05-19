if command -v fzf > /dev/null 2>&1; then
  source <(fzf --bash)
fi

if command -v pyenv > /dev/null 2>&1; then
  eval "$(pyenv init - bash)"
fi
