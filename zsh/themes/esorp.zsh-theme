function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

PROMPT='%{$FX[bold]$FG[111]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FX[bold]$FG[221]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"