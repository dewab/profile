is-executable assh || return

# I don't think I really need this, but it's here for reference
# alias ssh="assh wrapper ssh --"

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_assh" ]]; then
  autoload -Uz _assh
  typeset -g -A _comps
  _comps[assh]=_assh
fi

assh completion zsh >| "${ZSH_CACHE_DIR}/completions/_assh" &|
