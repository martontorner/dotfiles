[[ -x "$(command -v docker)" ]] && source <(docker completion bash)
[[ -x "$(command -v kubectl)" ]] && source <(kubectl completion bash)
[[ -x "$(command -v helm)" ]] && source <(helm completion bash)

[[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

_cd_repo() {
  COMPREPLY=( $(compgen -f -W "$(ls -1 ~/git)" -- "${COMP_WORDS[COMP_CWORD]}") )
}
complete -F _cd_repo -o nospace cd_repo

_docker_exec_bash() {
  COMPREPLY=( $(compgen -W "$(docker ps --format '{{.Names}}')" -- "${COMP_WORDS[COMP_CWORD]}") )
}
complete -F _docker_exec_bash docker_exec_bash

# Bash cannot autocomplete with aliases so we must do the most common ones by hand
complete -F _cd_repo -o nospace cdr

complete -F _docker d
complete -F _docker_exec_bash dlg
complete -F _docker_exec_bash dxc
complete -F _docker_exec_bash dxcb

complete -F _docker_compose c
