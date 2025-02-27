is-executable npm || return

# Move configuration files to .config
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
