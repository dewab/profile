TANZU_COMMANDS=( "tanzu" "tmc" "kapp" "kctrl" "imgpkg" "ytt" "vks-support-bundler" "velero" )

for cmd in "${TANZU_COMMANDS[@]}"; do
  if is-executable "$cmd"; then
    comp_file="${ZSH_CACHE_DIR}/completions/_${cmd}"
    if [[ ! -f "$comp_file" ]]; then
      mkdir -p "${ZSH_CACHE_DIR}/completions"
      "$cmd" completion zsh >| "$comp_file"
    fi

    autoload -Uz "_${cmd}"
    typeset -g -A _comps
    _comps["$cmd"]="_${cmd}"
  fi
done