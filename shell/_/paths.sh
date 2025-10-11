function _add_to_path_if_exists() { [[ -d "$1" ]] && export PATH="${1}:${PATH}"; }

# VS Code
_add_to_path_if_exists "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# JetBrains
_add_to_path_if_exists "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"

# Homebrew
_add_to_path_if_exists "${HOMEBREW_ROOT}/bin"
_add_to_path_if_exists "${HOMEBREW_ROOT}/sbin"
_add_to_path_if_exists "${HOMEBREW_ROOT}/opt/coreutils/libexec/gnubin"

# Python
_add_to_path_if_exists "${PYENV_ROOT}/bin"
