is-executable kubectl-krew || return

append_path PATH "${HOME}/.krew/bin"
