is-executable kubectl || return

alias k=kubectl

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_kubectl" ]]; then
  typeset -g -A _comps
  autoload -Uz _kubectl
  _comps[kubectl]=_kubectl
fi

kubectl completion zsh >| "${ZSH_CACHE_DIR}/completions/_kubectl" &|

compdef k=kubectl
