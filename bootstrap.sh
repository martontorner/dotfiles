#!/usr/bin/env sh

function get_dotfiles_directory() {
  local source="${BASH_SOURCE[0]:-$0}"

  while [ -L "$source" ]; do
    local dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

    source="$(readlink "$source")"
    [[ "$source" != /* ]] && source="$dir/$source"
  done

  echo "$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
}

DOTFILES="$(get_dotfiles_directory)"

# Setup path
echo "export DOTFILES=${DOTFILES}" > "${HOME}/.path"

# Create required files if not exist
touch "${HOME}/.extra"
touch "${HOME}/.gitconfig.user"

# Setup symlinks
find "$DOTFILES" -type f -name LINKS | while read -r links_file; do
  while IFS='=' read -r src tgt; do
    # Skip empty lines or comments
    [[ -z "${src}" || "${src}" =~ ^# ]] && continue

    # Expand variables
    src="${src/#\$DOTFILES/$DOTFILES}"
    tgt="${tgt/#\$HOME/$HOME}"

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "${dest}")"

    # Backup existing file if present
    [[ -e "${tgt}" && ! -L "${tgt}" ]] && mv "${tgt}" "${tgt}.bak" && echo "Backed up existing ${tgt} to ${tgt}.bak"

    # Create the symlink
    ln -fs "${src}" "${tgt}"
  done < "$links_file"
done
