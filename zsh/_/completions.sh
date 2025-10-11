[[ -x "$(command -v docker)" ]] && source <(docker completion zsh)
[[ -x "$(command -v kubectl)" ]] && source <(kubectl completion zsh)

[[ -s "${NVM_DIR}/bash_completion" ]] && source "${NVM_DIR}/bash_completion"

_cd_repo() { _files -W ~/git; }
compdef _cd_repo cd_repo

_docker_exec_bash() { _docker ps; }
compdef _docker_exec_bash docker_exec_bash
