# Prefer eza, then exa; otherwise leave the base ls aliases from .zshrc
if is-executable eza; then
  alias ll='eza --classify --long --icons --color-scale --all'
  alias l.='eza --list-dirs .* --icons --color-scale'
  alias la='eza --classify --icons --color-scale --all'
  return
fi

if is-executable exa; then
  alias ll='exa --classify --long --icons --color-scale --all'
  alias l.='exa --list-dirs .* --icons --color-scale'
  alias la='exa --classify --icons --color-scale --all'
fi
