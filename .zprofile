## tmux session check.
#if [ -z $TMUX ]; then
#    tmux list-sessions
#fi

## LS_COLORS
export LS_COLORS="$(vivid generate iceberg-dark)"

## Enviroment Path
export PATH="$PATH:/usr/local/bin/zsh"
