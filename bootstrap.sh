get_dotfiles_directory() {
  src=$0
  case "$src" in
    /*) : ;;
    *) src="$(pwd)/$src" ;;
  esac

  while [ -L "$src" ]; do
    dir=$(cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd)
    link=$(readlink "$src")
    case "$link" in
      /*) src="$link" ;;
      *) src="$dir/$link" ;;
    esac
  done

  cd -P "$(dirname "$src")" >/dev/null 2>&1 || exit 1
  pwd
}

DOTFILES=$(get_dotfiles_directory)

# Setup path
printf 'export DOTFILES=%s\n' "$DOTFILES" > "${HOME}/.path"

# Create extra configuration files if not exist
touch "${HOME}/.hushlogin"
touch "${HOME}/.extra"
touch "${HOME}/.gitconfig.user"

# Setup symlinks
find "$DOTFILES" -type f -name LINKS | while IFS= read -r links_file; do
  while IFS='=' read -r src tgt; do
    # skip comments and blank lines
    case "$src" in
      ''|\#*) continue ;;
    esac

    # variable expansion
    case "$src" in
      \$DOTFILES*) src=${src#\$DOTFILES} ; src="$DOTFILES$src" ;;
    esac
    case "$tgt" in
      \$HOME*) tgt=${tgt#\$HOME} ; tgt="$HOME$tgt" ;;
    esac

    mkdir -p "$(dirname "$tgt")"

    if [ -e "$tgt" ] && [ ! -L "$tgt" ]; then
      mv "$tgt" "$tgt.bak"
      echo "Backed up existing $tgt to $tgt.bak"
    fi

    ln -fs "$src" "$tgt"
  done < "$links_file"
done
