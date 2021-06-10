# Load Functions
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit
compinit

autoload -Uz colors
colors

autoload bashcompinit
bashcompinit
source /home/bucci/wp-completion.bash

setopt rm_star_silent
setopt interactivecomments
setopt prompt_subst
setopt transient_rprompt
setopt list_rows_first
setopt list_types

# History Settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Like an emacs.
bindkey -e

DISABLE_AUTO_UPDATE="true"

# Titlebar
case "${TERM}" in
kterm*|xterm*)
	precmd() {
	    echo -ne "\033]0;${LOGNAME}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac 

# Prompt
## Color
local C_ROOT="%F{red}"            # for Root
local C_SCL="%F{yellow}"          # for using Software Collection Library
local C_REMOTE_USER="%F{magenta}" # for Remote General User
local C_RESET="%f" # color reset

## for Software Collections
if [ $X_SCLS ]; then
    SCL="${C_SCL}[SCL]${C_RESET} "
fi

## Define Prompt
case ${UID} in
    0)
        PROMPT='[${C_ROOT}%B%n%b@${C_RESET}%m] ${SCL}%# '
        ;;
    *)
        PROMPT='[${C_REMOTE_USER}%B%n%b@${C_RESET}%m] ${SCL}%# '
        ;;
esac

## Define RPrompt
RPROMPT='[%35<...<%~]'

# END
