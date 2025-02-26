is-executable k9s || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_k9s" ]]; then
  typeset -g -A _comps
  autoload -Uz _k9s
  _comps[k9s]=_k9s
fi

k9s completion zsh >| "${ZSH_CACHE_DIR}/completions/_k9s" &|

compdef k=k9s
