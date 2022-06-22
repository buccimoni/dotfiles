## Load Functions
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit           # 補完機能を使用する
compinit

autoload -Uz colors             # 色を使用する
colors

autoload bashcompinit           # bash の補完機能を使う
bashcompinit
source ~/opt/wp-completion.bash # wp-cli の補完をする

# autoload -Uz vcs_info           # PROMPT で Git の情報を使う為に使用
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )

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

# Use color theme
export LS_COLORS="$(/usr/local/bin/vivid generate iceberg-dark)"

## Like an emacs.
bindkey -e

## Titlebar
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            # send terminal emulator's window name, tmux pane name.
            echo -ne "\033]0;${LOGNAME}@${HOST%%.*}:${PWD}\007"
            _cup=${$(pwd)/#\/home\/$USER/"~"}
            # set an omit string
            if [[ ${#_cup} -gt 23 ]]; then
                _dash="";
            else
                _dash="";
            fi

            RPROMPT="%F{cyan}%f${_dash}${_cup: -23}%F{cyan}%f"
            # unset _cup
            # unset _dash
        }
;;
esac 

## Alias
alias sudo='sudo '
alias ..='cd ..;'
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
local C_REMOTE_USER="%F{cyan}" # for Remote General User
local C_RESET="%f" # color reset

### for Software Collections
if [ ${X_SCLS} ]; then
    SCL="${C_SCL}[SCL]${C_RESET} "
fi

### Define Prompt
case ${UID} in
    0)
        # PROMPT='[${C_ROOT}%B%n%b@${C_RESET}%m] ${SCL}%# '
        PROMPT='${SCL}${C_ROOT}%#${C_RESET} '
        ;;
    *)
        # PROMPT='[${C_REMOTE_USER}%B%n%b@${C_RESET}%m] ${SCL}%# '
        PROMPT='${SCL}${C_REMOTE_USER}%#${C_RESET} '
        # PROMPT="%B%F{blue}[%(4~|/%2~|%~)/]%f%b %# "
        ;;
esac

### Define RPrompt
RPROMPT=''
# RPROMPT='[%35<...<%~]'
# RPROMPT='$vcs_info_msg_0_$vcs_info_msg_1_$vcs_info_msg_2_'
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats '[%b@%r] ' '%c%u %m'
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"


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

# tmux 使用時は fzf も tmux 用を使用する
#if [ $TMUX ]; then
#    export FZF_TMUX=1
#fi

## zplug
### zplug が無ければインストール
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

### Load
source ~/.zplug/init.zsh

### 使用するプラグインを宣言
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

### 使用するプラグインが無ければインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

### Then, source plugins and add commands to $PATH
if [ $TMUX ]; then
    zplug load --verbose
    export FZF_TMUX=1
fi

## fzf を使用する
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

