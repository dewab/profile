is-executable gitleaks || return

if [[ -f "${ZSH_CACHE_DIR}/completions/_gitleaks" ]]; then
    source "${ZSH_CACHE_DIR}/completions/_gitleaks"
fi

autoload -Uz _gitleaks
typeset -g -A _comps
_comps[gitleaks]=_gitleaks

command gitleaks completion zsh >| "${ZSH_CACHE_DIR}/completions/_gitleaks" &|
