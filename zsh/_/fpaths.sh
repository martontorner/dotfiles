function _add_to_fpath_if_exists() { [[ -d "$1" ]] && export FPATH="${1}:${FPATH}"; }

_add_to_fpath_if_exists "${HOMEBREW_ROOT}/share/zsh/site-functions"
_add_to_fpath_if_exists "${HOMEBREW_ROOT}/share/zsh-completions"
