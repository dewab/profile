is-executable zoxide || return

eval "$(zoxide init zsh)"

# Use Zoxide as a replacement for the `cd` command
alias cd='z'
