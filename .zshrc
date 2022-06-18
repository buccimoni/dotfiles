## Load Functions

zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit
compinit                        # 補完機能を使用する

autoload -Uz colors             # 色を使用する
colors

autoload bashcompinit
bashcompinit                    # bash の補完機能を使う
source ~/opt/wp-completion.bash # wp-cli の補完をする

setopt auto_list                # 補完候補一覧表示
setopt auto_menu                # 補完候補から順に補完
#setopt auto_cd                  # ディレクトリ名のみの入力で cd
setopt list_types               # 補完候補一覧でファイルタイプ表示
setopt rm_star_silent           # rm に * が含まれるときに問い合わせない
setopt interactivecomments      # コマンドラインでもコメントを使う
setopt prompt_subst             # prompt 変数内の変数を展開する
setopt transient_rprompt        # カレントの prompt にのみ rprompt を表示
setopt listtypes                # 補完リストでファイルタイプを表示
setopt share_history            # 複数の zsh 間で history を共有
setopt hist_ignore_all_dups     # 重複した入力は記録しない
setopt print_eight_bit          # 日本語ファイル名表示に対応する

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
PERCOL=~/.zplug/bin/fzf
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

## zplug
# zplug が無ければインストール
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Load
source ~/.zplug/init.zsh

# 使用するプラグインを宣言
#zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
#zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# 使用するプラグインが無ければインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
if [ $TMUX ]; then
    zplug load --verbose
fi

## fzf function
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

# fzf keybind
zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

