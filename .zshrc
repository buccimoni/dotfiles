## Load Functions
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit
compinit

autoload -Uz colors
colors

autoload bashcompinit
bashcompinit
source ~/wp-completion.bash

setopt auto_list                # 補完候補一覧表示
setopt auto_menu                # 補完候補から順に補完
#setopt auto_cd                  # ディレクトリ名のみの入力で cd
setopt list_types               # 補完候補一覧でファイルタイプ表示
setopt rm_star_silent           # rm に * が含まれるときに問い合わせない
setopt interactivecomments      # コマンドラインでもコメントを使う
setopt prompt_subst             # prompt 変数内の変数を展開する
setopt transient_rprompt        # カレントの prompt にのみ rprompt を表示
#setopt list_rows_first          # 補完リストを水平にソートして表示
setopt listtypes                # 補完リストでファイルタイプを表示
setopt share_history            # 複数の zsh 間で history を共有
setopt hist_ignore_all_dups     # 重複した入力は記録しない

## History Settings
HISTFILE=~/.histfile
HISTSIZE=10000                  # Memory に保持される history の件数
SAVEHIST=100000                 # HISTFILE に保存される history の件数

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
alias ls='/bin/ls -p --color=auto'
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
PERCOL=~/.fzf/bin/fzf
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
