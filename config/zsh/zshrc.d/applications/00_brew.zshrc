if (( ! $+commands[brew] )); then
  local _brew_candidates=(
    "/opt/homebrew/bin/brew"
    "/usr/local/bin/brew"
    "/home/linuxbrew/.linuxbrew/bin/brew"
    "${HOME}/.linuxbrew/bin/brew"
  )

  for _candidate in "${_brew_candidates[@]}"; do
    if [[ -x "${_candidate}" ]]; then
      BREW_LOCATION="${_candidate}"
      break
    fi
  done

  unset _brew_candidates _candidate
  [[ -z "${BREW_LOCATION}" ]] && return
fi

local _brew_cmd="${BREW_LOCATION:-$(command -v brew)}"
[[ -z "${_brew_cmd}" ]] && return

if [[ -z "${HOMEBREW_PREFIX}" ]]; then
  eval "$("$_brew_cmd" shellenv)"
fi

unset BREW_LOCATION

# Add brew completions to shell (avoid extra brew --prefix when HOMEBREW_PREFIX is set)
if (( $+commands[brew] )); then
  local _brew_prefix="${HOMEBREW_PREFIX:-$("$_brew_cmd" --prefix)}"
  append_path FPATH "${_brew_prefix}/share/zsh/site-functions"
  append_path FPATH "${_brew_prefix}/completions/zsh"
  autoload -Uz _brew
  compdef _brew brew
  unset _brew_prefix
fi

unset _brew_cmd

function brew-up () {
	brew update || return $?
	brew upgrade || return $?
	brew upgrade --greedy --cask || return $?
	brew cleanup || return $?
}
