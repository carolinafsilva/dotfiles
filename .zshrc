#!/bin/zsh

# Zsh Modules

autoload -Uz compinit
compinit

# Zsh style
zstyle ':completion:*' menu yes select

# Zsh Options

setopt interactivecomments

setopt prompt_subst

setopt complete_aliases

setopt auto_pushd
setopt pushd_minus
setopt pushd_ignore_dups

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# History

SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history

# Zsh Plugins

. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh && {
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,bold"
} || true

. /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh && {
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=magenta,bold"
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"

  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
} || true

. /opt/homebrew/opt/zsh-git-prompt/zshrc.sh && {
  ZSH_THEME_GIT_PROMPT_PREFIX="["
  ZSH_THEME_GIT_PROMPT_SUFFIX="]"
  ZSH_THEME_GIT_PROMPT_SEPARATOR=""

  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
  ZSH_THEME_GIT_PROMPT_BEHIND=" %f%{↓%G%}"
  ZSH_THEME_GIT_PROMPT_AHEAD=" %f%{↑%G%}"

  ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg[green]%}%{✚%G%}"
  ZSH_THEME_GIT_PROMPT_CHANGED=" %{$fg[blue]%}%{✚%G%}"
  ZSH_THEME_GIT_PROMPT_CONFLICTS=" %{$fg[red]%}%{✖%G%}"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[magenta]%}%{?%G%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
} || true

# Prompt

precmd () {
  STATUS=$?

  PROMPT="%F{magenta}%n%f %1~"

  PROMPT+=" "

  [[ $(git rev-parse --git-dir 2>/dev/null) ]] && PROMPT+="$(git_super_status)%f "

  case ${STATUS} in
    "0" | "130")
      PROMPT+="> "
      ;;
    "1")
      PROMPT+="%F{red}> %f"
      ;;
    *)
      PROMPT+="%F{magenta}> %f"
      ;;
  esac

  unset STATUS
}

# Aliases

if [[ -f ~/.aliases.zsh ]]; then
  . ~/.aliases.zsh
fi

# Functions

if [[ -f ~/.functions.zsh ]]; then
  . ~/.functions.zsh
fi

# Opam
if [[ ${HOME}/.opam/opam-init/init.zsh ]]; then
  . ${HOME}/.opam/opam-init/init.zsh &> /dev/null || true
fi

export PATH="$HOME/.opam/default/bin:$PATH"

# Haskell
if [[ -f "$HOME/.ghcup/env" ]]; then
  . "$HOME/.ghcup/env"
fi

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
