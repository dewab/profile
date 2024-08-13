is-executable az || return

is-readable ${HOMEBREW_PREFIX}/etc/bash_completion.d/az && source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az
