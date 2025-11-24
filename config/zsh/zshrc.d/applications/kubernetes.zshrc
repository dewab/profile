# Kubernetes tooling (kubectl, kubecolor, kubectx/kubens, krew)
is-executable kubectl || return

if is-directory "${HOME}/.krew/bin"; then
  append_path PATH "${HOME}/.krew/bin"
fi

typeset -i have_kubecolor=0
is-executable kubecolor && have_kubecolor=1

alias k=kubectl
alias ku='kubectl config use-context'

# Keep kubectl completions available even when kubecolor is aliased to kubectl.
_kubectl_completion_file="${ZSH_CACHE_DIR}/completions/_kubectl"
[[ -f "${_kubectl_completion_file}" ]] || command kubectl completion zsh >| "${_kubectl_completion_file}" &|

autoload -Uz _kubectl
autoload -Uz add-zsh-hook
__kube__compdefs() {
  compdef _kubectl kubectl
  compdef k=kubectl
  (( have_kubecolor )) && compdef kubecolor=kubectl
  add-zsh-hook -d precmd __kube__compdefs 2>/dev/null
}
add-zsh-hook precmd __kube__compdefs

if (( have_kubecolor )); then
  alias kubectl='kubecolor'
fi

if is-executable kubectx; then
  alias kctx='kubectx'
  alias kns='kubens'
fi

if is-executable helm; then
  alias h=helm

  _helm_completion_file="${ZSH_CACHE_DIR}/completions/_helm"
  if [[ ! -f "${_helm_completion_file}" ]]; then
    autoload -Uz _helm
    typeset -g -A _comps
    _comps[helm]=_helm
  fi

  [[ -f "${_helm_completion_file}" ]] || command helm completion zsh >| "${_helm_completion_file}" &|
fi

if is-executable k9s; then
  _k9s_completion_file="${ZSH_CACHE_DIR}/completions/_k9s"
  if [[ ! -f "${_k9s_completion_file}" ]]; then
    typeset -g -A _comps
    autoload -Uz _k9s
    _comps[k9s]=_k9s
  fi

  [[ -f "${_k9s_completion_file}" ]] || command k9s completion zsh >| "${_k9s_completion_file}" &|
fi
