is-executable helm || return

alias h=helm

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_helm" ]]; then
  autoload -Uz _helm
  typeset -g -A _comps
  _comps[helm]=_helm
fi

helm completion zsh >| "${ZSH_CACHE_DIR}/completions/_helm" &|
