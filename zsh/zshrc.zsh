function _source_if_exists() { [[ -f "$1" ]] && source "$1"; }

autoload -U zmv
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

setopt extended_history       # record timestamp of command in HISTFILE
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# Path
_source_if_exists "${HOME}/.path"

# General
_source_if_exists "${DOTFILES}/shell/_/exports.sh"
_source_if_exists "${DOTFILES}/shell/_/paths.sh"
_source_if_exists "${DOTFILES}/shell/_/functions.sh"
_source_if_exists "${DOTFILES}/shell/_/aliases.sh"

# Specific
_source_if_exists "${DOTFILES}/zsh/_/completions.sh"
_source_if_exists "${DOTFILES}/zsh/_/fpaths.sh"
_source_if_exists "${DOTFILES}/zsh/_/prompts.sh"

# Plugins
# TODO: can we move this to an external file?
_source_if_exists "${HOMEBREW_ROOT}/opt/nvm/nvm.sh"
_source_if_exists "${HOMEBREW_ROOT}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
_source_if_exists "${HOMEBREW_ROOT}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Overrides
_source_if_exists "${HOME}/.extra"
