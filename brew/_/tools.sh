function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

_source_if_exists "${HOMEBREW_ROOT}/opt/nvm/nvm.sh"
