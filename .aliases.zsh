alias mkdir='mkdir -p'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls -Gv'
alias ll='ls -lh'
alias la='ls -lhA'
alias l.='ls -lhd .*'

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias tree='tree -a -I ".git"'

alias code='code -r'
alias v='vim'

type nvim >/dev/null && {
  alias vim='nvim'
}

alias f='open -a Finder .'
