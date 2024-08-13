is-executable fzf || return

if [[ -f "${ZSH_CACHE_DIR}/completions/_fzf" ]]; then
  autoload -Uz _fzf
  typeset -g -A _comps
  _comps[fzf]=_fzf
fi

fzf --zsh >| "${ZSH_CACHE_DIR}/completions/_fzf" &|
