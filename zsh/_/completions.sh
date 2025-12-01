for f in "${HOME}/.zsh_completions/*"; do
  [[ -r "$f" ]] && source "$f"
done

_cd_repo() { _files -W ~/git; }
compdef _cd_repo cd_repo

_docker_exec_bash() { _docker ps; }
compdef _docker_exec_bash docker_exec_bash
