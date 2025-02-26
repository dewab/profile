is-executable velero || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_velero" ]]; then
  typeset -g -A _comps
  autoload -Uz _velero
  _comps[velero]=_velero
fi

velero completion zsh >| "${ZSH_CACHE_DIR}/completions/_velero" &|
