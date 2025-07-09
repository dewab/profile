is-executable atuin || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_atuin" ]]; then
  autoload -Uz _atuin
  typeset -g -A _comps
  _comps[atuin]=_atuin
fi

atuin gen-completions --shell zsh >| "${ZSH_CACHE_DIR}/completions/_atuin" &|
