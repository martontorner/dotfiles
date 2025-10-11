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

# Generate a random password
function random_password_generator() {
  if [ -z "$1" ]; then
    echo "random_password_generator: Create a random password

Usage: random_password_generator <length> [<use_special_characters = 0>]
"

    return;
  fi

  length=$1
  use_special_characters=${2:-0}

  if [ $use_special_characters -eq 1 ]; then
    CHARS=( \
      a b c d e f g h i j k l m n o p q r s t u v w x y z \
      A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \
      0 1 2 3 4 5 6 7 8 9 \
      \; \: \. \~ \! \@ \# \$ \% \^ \& \* - + = \? \
    )
  else
    CHARS=( \
      a b c d e f g h i j k l m n o p q r s t u v w x y z \
      A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \
      0 1 2 3 4 5 6 7 8 9 \
    )
  fi

  CNUM="${#CHARS[@]}"

  result=""

  let POSCNT=0;
  while [ 1 -eq 1 ]; do
    if [ $POSCNT -ge $length ]; then
      break;
    fi

    result="${result}${CHARS[${RANDOM}%${CNUM}]}"

    let POSCNT=$POSCNT+1
  done

  echo "${result}"
}
alias rpwdgen='random_password_generator'

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

set +e
