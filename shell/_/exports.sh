# General
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export HISTFILE="${HOME}/.shell_history"
export HISTSIZE="32768"
export HISTFILESIZE="${HISTSIZE}"
export HISTCONTROL="ignoreboth"
export HISTIGNORE="clear:history:[bf]g:exit:date:* --help"
export HISTTIMEFORMAT=': %s:0;'
export SAVEHIST="${HISTSIZE}"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_DATA_HOME="${HOME}/.local/share"

export EDITOR="vim"
export VISUAL="code"

export MANPAGER="less -X"

export GPG_TTY="$(tty)"

# Internal
export IP_REGEX="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"
export MAC_REGEX="[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}"

# Mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# Homebrew
export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_NO_ENV_HINTS=1

# Node
export NVM_DIR="${HOME}/.nvm"

# Python
export PYENV_ROOT="${HOME}/.pyenv"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Docker BuildKit
export BUILDX_GIT_CHECK_DIRTY=1
export BUILDX_GIT_INFO=1
export BUILDX_GIT_LABELS=full
