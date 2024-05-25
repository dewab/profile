if (( ! $+commands[brew] )); then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_LOCATION="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_LOCATION="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_LOCATION="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    BREW_LOCATION="$HOME/.linuxbrew/bin/brew"
  else
    return
  fi
fi

if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if [[ -z $BREW_LOCATION ]]; then
    eval "$(brew shellenv)"
  else
    eval "$("$BREW_LOCATION" shellenv)"
  fi
fi

unset BREW_LOCATION

# Add brew completions to shell
append_path FPATH $(brew --prefix)/share/zsh/site-functions

function brew-up () {
	brew update
	brew upgrade
	brew cleanup
}
