function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

PROMPT='🙉  @ %{$FX[bold]$FG[111]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info)$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$FX[bold]$FG[221]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FX[bold]$FG[221]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
