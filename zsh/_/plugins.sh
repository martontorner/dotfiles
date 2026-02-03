function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

_source_if_exists "${HOMEBREW_ROOT}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
_source_if_exists "${HOMEBREW_ROOT}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
