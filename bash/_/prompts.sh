__prompt_length () {
  echo -e "$1" | sed -r 's/\\\[[^]]*\\\]//g' | { read -r s; echo "${#s}"; }
}

__with_color () {
  echo "\[\e[${1}m\]"
}

__with_print () {
  echo "${1}"
}

__set_options () {
  :
}

__unset_options () {
  :
}

source "${DOTFILES}/shell/_/prompts.sh"

_update_history () {
  history -a

  # temporary file for cleaned history
  TMP_FILE="$(mktemp)"

  # state variable for Bash #<epoch> lines
  bash_epoch=""

  # ensure history file exists
  [[ -f "$HISTFILE" ]] || touch "$HISTFILE"

  # read the mixed file line by line
  while IFS= read -r line; do
    if [[ "$line" =~ ^#([0-9]+)$ ]]; then
      # Bash timestamp line
      bash_epoch="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^: ]]; then
      # Zsh extended history line, preserve as-is
      echo "$line" >> "$TMP_FILE"
      bash_epoch=""
    elif [[ -n "$bash_epoch" ]]; then
      # convert Bash command with previous #epoch to Zsh format
      echo ": ${bash_epoch}:0;${line}" >> "$TMP_FILE"
      bash_epoch=""
    else
      # no timestamp, preserve raw (optional, or skip)
      echo "$line" >> "$TMP_FILE"
    fi
  done < "$HISTFILE"

  # replace original history with cleaned version
  mv "$TMP_FILE" "$HISTFILE"
}

PROMPT_COMMAND="_update_prompt; _update_history"
