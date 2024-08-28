is-executable pandoc || return

if [[ ! -f "${ZSH_CACHE_DIR}/completions/_pandoc" ]]; then
  autoload -Uz _pandoc
  typeset -g -A _comps
  _comps[pandoc]=_pandoc
fi

pandoc --bash-completion >| "${ZSH_CACHE_DIR}/completions/_pandoc" &|
