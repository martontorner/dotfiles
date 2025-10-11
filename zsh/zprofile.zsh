function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

# Path
_source_if_exists "${HOME}/.path"

# Login
_source_if_exists "${DOTFILES}/shell/_/banner.sh"

# Interactive
_source_if_exists "${HOME}/.zshrc"
