is-executable zoxide || return

eval "$(zoxide init zsh)"

# Use Zoxide as a replacement for the `cd` command
alias cd='z'

# fzf-powered interactive jump
if is-executable fzf; then
  zf() {
    local dir
    dir=$(zoxide query -l | fzf --prompt='zoxide> ' --preview='ls -a {}' --preview-window=down:40%) || return
    cd "${dir}"
  }
fi
