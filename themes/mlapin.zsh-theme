prompt_host_color="green"
if [[ -n "${SSH_CLIENT}" ]]; then
  prompt_host_color="red"
fi

function _prompt_info() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo $(git_prompt_info)
  elif $(hg root &> /dev/null); then
    echo $(hg_prompt_info 2> /dev/null) || ""
  fi
}

function custom_git_prompt() {
  short_sha=$(git_prompt_short_sha) || return
  info=$(git_prompt_info) || info='%{%B%F{red}%}non-local'
  echo "[%{%F{green}%}${info}$(git_prompt_ahead)%{%F{cyan}%}${short_sha}$(git_prompt_status)%{%f%b%}]"
}

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY="%{%B%F{red}%}*%{%f%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{%B%F{red}%}!%{%f%b%}"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{%B%F{red}%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{%B%F{red}%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{%B%F{red}%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{%b%F{yellow}%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{%b%F{green}%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{%b%F{magenta}%}untracked"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" "
ZSH_THEME_GIT_PROMPT_SHA_AFTER=""

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# see manpage of strftime(3)
local prompt_time='%{$fg[yellow]%}%D{%Y-%m-%d %T}%{$reset_color%}'
local prompt_path='%{$fg[blue]%}${PWD/#$HOME/~}%{$reset_color%}'
local prompt_user_at_host='%{$fg['$prompt_host_color']%}%n@%m%{$reset_color%}'
local prompt_exit_code='%(?..%{$fg[red]%}%?%{$reset_color%})'

PS1="%(?..[ %{%B%F{red}%}%?%{%f%b%} ])
[$prompt_time] $prompt_user_at_host:$prompt_path "'$(custom_git_prompt)
%{%F{green}%}%(!.#.$)%{%f%} '

RPROMPT=''
