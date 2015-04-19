function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$FG[222]%}<branch>%{$reset_color%}>\
< at %{$FG[222]%}<bookmark>%{$reset_color%}>\
%{$FG[222]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$FG[222]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$FG[222]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

PROMPT='
%{$FG[208]%}%n%{$reset_color%} in %{$FG[247]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$FG[222]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[222]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
