__prompt_length () {
  echo -e "$1" | sed -r 's/\%\{[^{]*\%\}//g' | { read -r s; echo "${#s}"; }
}

__with_color () {
  echo "%{\e[${1}m%}"
}

__with_print () {
  echo "${1}"
}

__set_options () {
  set -o ksharrays
}

__unset_options () {
  set +o ksharrays
}

source "${DOTFILES}/shell/_/prompts.sh"

precmd_functions+=(_update_prompt)
