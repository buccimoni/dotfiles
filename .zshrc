## Load Functions
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit
compinit

autoload -Uz colors
colors

autoload bashcompinit
bashcompinit
source /home/bucci/wp-completion.bash

setopt auto_list
setopt auto_menu
setopt auto_cd
setopt list_types
setopt rm_star_silent
setopt interactivecomments
setopt prompt_subst
setopt transient_rprompt
setopt list_rows_first
setopt list_types

## History Settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

## Like an emacs.
bindkey -e

DISABLE_AUTO_UPDATE="true"

## Titlebar
case "${TERM}" in
kterm*|xterm*)
	precmd() {
	    echo -ne "\033]0;${LOGNAME}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac 

## Aliase
alias sudo='sudo '
alias ..='cd ../'
alias vi='/usr/local/bin/vim'
alias view='/usr/local/bin/vim -M'
alias ll='/bin/ls -alF --color=auto'

## Disable Commands
disable r

## vimpager
export PAGER=/usr/local/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

## Prompt
### Color
local C_ROOT="%F{red}"            # for Root
local C_SCL="%F{yellow}"          # for using Software Collection Library
local C_REMOTE_USER="%F{magenta}" # for Remote General User
local C_RESET="%f" # color reset

### for Software Collections
if [ $X_SCLS ]; then
    SCL="${C_SCL}[SCL]${C_RESET} "
fi

### Define Prompt
case ${UID} in
    0)
        PROMPT='[${C_ROOT}%B%n%b@${C_RESET}%m] ${SCL}%# '
        ;;
    *)
        PROMPT='[${C_REMOTE_USER}%B%n%b@${C_RESET}%m] ${SCL}%# '
        ;;
esac

### Define RPrompt
RPROMPT='[%35<...<%~]'

## tmux session auto attach
PERCOL=/usr/local/bin/fzf
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

# END
