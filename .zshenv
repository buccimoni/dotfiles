# export TERM=xterm-256color
export LANG=C
export LC_CTYPE=en_US.UTF-8
export EDITOR=/usr/local/bin/vim
typeset -U path PATH
# export PATH="$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin"
path=(/usr/bin /usr/sbin /usr/local/bin /usr/local/sbin $HOME/bin(N-/) $HOME/.local/bin(N-/) $path)
