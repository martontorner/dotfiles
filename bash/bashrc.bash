function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

# Set emacs keybindings
set -o emacs

shopt -s histappend

# Path
_source_if_exists "${HOME}/.path"

# Homebrew
_source_if_exists "${DOTFILES}/brew/_/exports.sh"
_source_if_exists "${DOTFILES}/brew/_/tools.sh"

# General
_source_if_exists "${DOTFILES}/shell/_/exports.sh"
_source_if_exists "${DOTFILES}/shell/_/paths.sh"
_source_if_exists "${DOTFILES}/shell/_/functions.sh"
_source_if_exists "${DOTFILES}/shell/_/aliases.sh"

# Specific
_source_if_exists "${DOTFILES}/bash/_/completions.sh"
_source_if_exists "${DOTFILES}/bash/_/prompts.sh"

# Tools
_source_if_exists "${DOTFILES}/eza/_/exports.sh"

# Overrides
_source_if_exists "${HOME}/.extra"
