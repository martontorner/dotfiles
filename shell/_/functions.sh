set -e

# Pretty print history with timestamps
function history_pretty() {
  if [ ! -f "$HISTFILE" ]; then
    echo "History file not found: $HISTFILE" >&2
    return 1
  fi

  # Detect GNU vs BSD date syntax
  if date -d @0 >/dev/null 2>&1; then
    dateflag="-d"
  else
    dateflag="-r"
  fi

  awk -v dateflag="$dateflag" '
    BEGIN { OFS="  " }
    /^: [0-9]+:/ {
      line = substr($0, 3)
      split(line, a, ";")
      cmd = a[2]
      split(a[1], b, ":")
      epoch = b[1]
      cmdstr = "date " dateflag " @" epoch " \"+%F %T\""
      cmdstr | getline ts
      close(cmdstr)
      print ts, cmd
    }
  ' "$HISTFILE"
}

# Change to repo in ~/git/ directory
function cd_repo() {
  if [ -z "$1" ]; then
    echo "cd_repo: Change to repo in ~/git/ directory

Usage: cd_repo <name>
"

    return;
  fi

  cd ~/git/$1
}
alias cdr='cd_repo'


# Print ASCII table (decimal (d), octal (o), hex (h)) - works only for MAC
function ascii() {
  if [ -z "$1" ]; then
    echo "ascii: Print ASCII table: decimal (d), octal (o), hex (h)

Usage: ascii <table>
"

    return;
  fi

  man ascii | grep -A 18 --color=never -e "The [$1].* set:" | tail -n 18;
}


# Convert epoch timestamp to ISO formatted datetime
function epoch2iso() {
  if [ -t 0 ]; then
    e=$1
    shift 1;
  else
    e=$(</dev/stdin)
  fi

  p=${1:-0}

  if [ -z "$e" ]; then
    echo "epoch2iso: Convert epoch timestamp to ISO formatted datetime

Usage: epoch2iso <epoch> [<precision = 0>]

Precision is counted from seconds (so 9 means nanosecond precision).
"

    return;
  fi

  # convert to seconds for date (truncate fractional digits if precision > 0)
  if [ "$p" -gt 0 ]; then
      # scale down to seconds with decimal
      secs=$(awk "BEGIN{printf \"%.${p}f\", $e/10^$p}")
  else
      secs=$e
  fi

  # Use GNU date or BSD/macOS date
  if date --version >/dev/null 2>&1; then
      # GNU date
      date -d "@$secs" --iso-8601=seconds
  else
      # BSD/macOS date
      date -r "${secs%.*}" -u +"%Y-%m-%dT%H:%M:%S"
  fi
}

# Generate a random password (32 alphanumeric characters)
function random_password_generator() {
  if [ $# -gt 1 ]; then
    echo "random_password_generator: Create a random password

Usage: random_password_generator [<length = 32>]
"

    return;
  fi

  # random password generator (32 alphanumeric characters)
  cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c "${1:-32}" | paste
}
alias rpwdgen='random_password_generator'

# Generate an apple-like password (16 lowercase, 1 uppercase, 1 digit, randomized, hyphenated)
function apple_password_generator() {
  if [ $# -gt 0 ]; then
    echo "apple_password_generator: Create an apple-like password

Usage: apple_password_generator
"

    return;
  fi

  { shuf -e {a..z} | head -16; shuf -e {A..Z} | head -1; shuf -e {0..9} | head -1; } | shuf | paste -sd '' | fold -w6 | paste -sd '-'
}
alias apwdgen='apple_password_generator'

# Enter a docker container shell
function docker_exec_shell() {
  if [ -z "$1" ]; then
    echo "docker_exec_shell: Enter a docker container shell

Usage: docker_exec_shell <name>
"

    return;
  fi

  container=$1

  # Try Config.Shell from image
  shell=$(docker inspect --format='{{.Config.Shell}}' "${container}" 2>/dev/null | tr -d '[],"')

  # Fallbacks if Config.Shell is empty or does not exist in container
  if ! docker exec "${container}" test -x "$shell" >/dev/null 2>&1; then
    for candidate in bash sh ash; do
      if docker exec "${container}" test -x "/${candidate}" >/dev/null 2>&1; then
          shell="/$candidate"
          break
      fi
    done
  fi

  if [ -z "$shell" ]; then
    # Last resort: exec the container's PID 1
    shell=$(docker exec "${container}" readlink /proc/1/exe 2>/dev/null)
  fi

  if [ -z "$shell" ]; then
    echo "No shell found in container ${container}"
    return 1
  fi

  docker exec -it "${container}" "${shell}"
}
alias dxcs='docker_exec_shell'

# Clone a github repo by account and by name
function github_clone() {
  if [ -z "$2" ]; then
    echo "github_clone: Clone a github repo by account and by name

Usage: github_clone_own <account> <name>
"

    return;
  fi

  account=$1
  name=$2
  shift 2

  # TODO: add https support as well with a preferred method env variable
  git clone "git@github.com:${account}/${name}.git" $@
}
alias ghc='github_clone'

# Clone own github repo by name
function github_clone_own() {
  if [ -z "$1" ]; then
    echo "github_clone_own: Clone own (${GITHUB_USERNAME}) github repo by name

Usage: github_clone_own <name> [<path>]
"

    return;
  fi

  github_clone "${GITHUB_USERNAME}" $@
}
alias ghco='github_clone_own'

# Find nearest .venv file
function venv_find_dotvenv() {
  local dir="$PWD"

  while true; do
    if [[ -d "$dir/.venv" ]]; then
      echo "$dir/.venv"
      return 0
    fi

    [[ "$dir" == "/" ]] && break
    dir="$(dirname "$dir")"
  done

  return 1
}

# Colorize help output of a command using bat
function help() {
  "$@" --help 2>&1 | bat --plain --language=help
}

# Colorize help output of a command using bat
function wttr() {
  if [ $# -gt 1 ]; then
    echo "wttr: Get weather information

Usage: wttr [<location>]

If you specify a location, it will show the weather for that location. If you
don't specify a location, it will show the weather for your current location
based on your IP address.
"

    return 1;
  fi

  curl -s "wttr.in/${1}"
}

set +e
