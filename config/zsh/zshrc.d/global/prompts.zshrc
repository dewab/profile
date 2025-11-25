if [[ -z "${prompt_tool}" ]]; then
    source "${ZDOTDIR}/zshrc.d/global/mine.prompt"
else
    source "${ZDOTDIR}/zshrc.d/global/${prompt_tool}.prompt"
fi
