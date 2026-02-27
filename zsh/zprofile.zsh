function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

# Path
_source_if_exists "${HOME}/.path"

# Login
_source_if_exists "${DOTFILES}/shell/_/banners.sh"

# Interactive
# zsh automatically sources .zshrc for interactive shells
if [[ $- == *i* ]] && [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
    tmux attach 2>/dev/null || tmux new
fi
