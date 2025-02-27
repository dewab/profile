is-executable tanzu || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_tanzu" ]]; then
  autoload -Uz _tanzu
  typeset -g -A _comps
  _comps[tanzu]=_tanzu
fi

tanzu completion zsh >| "${ZSH_CACHE_DIR}/completions/_tanzu" &|
