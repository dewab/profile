is-executable wget || return

# Move files for XDG support
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
