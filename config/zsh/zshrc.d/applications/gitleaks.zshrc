is-executable gitleaks || return

autoload -Uz _gitleaks command_completion
(( ${+_comps} )) || typeset -g -A _comps
_comps[gitleaks]=_gitleaks
command_completion "${ZSH_CACHE_DIR}/completions/_gitleaks" gitleaks completion zsh &|
