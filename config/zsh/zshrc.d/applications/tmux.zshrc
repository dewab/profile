is-executable tmux || return
is-executable tmuxinator && alias mux=tmuxinator

autoload -Uz tm

# fzf picker for tmux sessions (popup when available)
if is-executable fzf-tmux; then
  tmux-fzf-session() {
    local session
    session=$(tmux list-sessions -F '#S' 2>/dev/null | fzf-tmux -p 80% --prompt='tmux> ') || return
    if [[ -n "${TMUX}" ]]; then
      tmux switch-client -t "${session}"
    else
      tmux attach -t "${session}"
    fi
  }
fi
