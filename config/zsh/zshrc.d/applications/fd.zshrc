is-executable fd || return

# Use fd as the default command for fzf
is-executable fzf && {
  export FZF_DEFAULT_COMMAND='fd --hidden --follow --strip-cwd-prefix --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type=d --hidden --follow --strip-cwd-prefix --exclude .git'
}
