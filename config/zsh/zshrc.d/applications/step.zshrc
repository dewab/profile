is-executable step || return

if [[ -f "${ZSH_CACHE_DIR}/completions/_step" ]]; then
  # source <(cat "${ZSH_CACHE_DIR}/completions/_step")
  autoload -Uz _step
  typeset -g -A _comps
  _comps[step]=_step
fi
  
# step may be a function defined in 1Password CLI
command step completion zsh >| "${ZSH_CACHE_DIR}/completions/_step" &|
