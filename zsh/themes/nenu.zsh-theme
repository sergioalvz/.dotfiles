# "nenu" theme by Sergio Álvarez-Suárez
# 2017

ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function get_git_info {
  echo "$(git_prompt_info) $(git_prompt_status)"
}

PROMPT='%{$FX[bold]$FG[221]%}↳%{$reset_color%} %{$FX[bold]$FG[111]%}$(collapse_pwd)%{$reset_color%}%{$FX[bold]$FG[221]%}$(get_git_info)%{$reset_color%}
%{$FX[bold]$FG[197]%}$%{$reset_color%} '
