is-executable fzf || return

is-readable ${XDG_DATA_HOME}/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh && source ${XDG_DATA_HOME}/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# Load fzf key bindings (ctrl-t, ctrl-r, alt-c)
_fzf_key_bindings_scripts=(
  "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
  "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  "/usr/local/opt/fzf/shell/key-bindings.zsh"
  "${HOME}/.fzf/shell/key-bindings.zsh"
  "/usr/share/fzf/key-bindings.zsh"
)

for _fzf_key_binding_script in "${_fzf_key_bindings_scripts[@]}"; do
  if is-readable "${_fzf_key_binding_script}"; then
    source "${_fzf_key_binding_script}"
    break
  fi
done

unset _fzf_key_bindings_scripts _fzf_key_binding_script

# Load fzf command completions
_fzf_completion_scripts=(
  "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
  "/opt/homebrew/opt/fzf/shell/completion.zsh"
  "/usr/local/opt/fzf/shell/completion.zsh"
  "${HOME}/.fzf/shell/completion.zsh"
  "/usr/share/fzf/completion.zsh"
  "/usr/share/doc/fzf/examples/completion.zsh"
)

for _fzf_completion_script in "${_fzf_completion_scripts[@]}"; do
  if is-readable "${_fzf_completion_script}"; then
    source "${_fzf_completion_script}"
    break
  fi
done

unset _fzf_completion_scripts _fzf_completion_script
