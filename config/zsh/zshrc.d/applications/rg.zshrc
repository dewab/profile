is-executable rg || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_rg" ]]; then
  autoload -Uz _rg
  typeset -g -A _comps
  _comps[rg]=_rg
fi

command rg --generate=complete-zsh >| "${ZSH_CACHE_DIR}/completions/_rg" &|
