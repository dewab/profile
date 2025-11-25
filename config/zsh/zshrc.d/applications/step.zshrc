is-executable step || return

# step may be a function defined in 1Password CLI
autoload -Uz _step command_completion
(( ${+_comps} )) || typeset -g -A _comps
_comps[step]=_step
command_completion "${ZSH_CACHE_DIR}/completions/_step" step completion zsh &|
