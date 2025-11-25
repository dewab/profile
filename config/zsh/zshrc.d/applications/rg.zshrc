is-executable rg || return

autoload -Uz _rg command_completion
(( ${+_comps} )) || typeset -g -A _comps
_comps[rg]=_rg
command_completion "${ZSH_CACHE_DIR}/completions/_rg" rg --generate=complete-zsh &|
