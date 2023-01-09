## Load Functions
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit && compinit   # 補完機能を使用する
autoload -Uz colors && colors       # 色を使用する

# RPM パッケージ付属の関数を fpath に追加
fpath=(/usr/share/zsh/site-functions $fpath) 

## root に適用しない設定
if [ ${UID} -ne 0 ]; then
    _cache_hosts=($(perl -ne 'if (/^([A-z][A-z0-9.-]+)(?:,| )/) { print "$1\n";}' ~/.ssh/known_hosts))
    autoload bashcompinit && bashcompinit   # bash の補完機能を使う
    source ~/opt/wp-completion.bash         # wp-cli の補完をする
fi

## zsh のオプション設定
setopt auto_list                # 補完候補一覧表示
setopt auto_menu                # 補完候補から順に補完
setopt list_types               # 補完候補一覧でファイルタイプ表示
setopt rm_star_silent           # rm に * が含まれるときに問い合わせない
setopt interactivecomments      # コマンドラインでもコメントを使う
setopt prompt_subst             # prompt 変数内の変数を展開する
setopt transient_rprompt        # カレントの prompt にのみ rprompt を表示
setopt listtypes                # 補完リストでファイルタイプを表示
setopt share_history            # 複数の zsh 間で history を共有
setopt hist_ignore_all_dups     # 重複した入力は記録しない
setopt print_eight_bit          # 日本語ファイル名表示に対応する

## History の設定
HISTFILE=~/.histfile
HISTSIZE=10000                  # Memory に保持される history の件数
SAVEHIST=100000                 # HISTFILE に保存される history の件数

## ls コマンドの表示色を設定
# - Download
# https://github.com/sharkdp/vivid/releases
# - Install (x86_64)
# tar xzf vivid-vx.y.z-x86_64-unknown-linux-musl.tar.gz
# cd vivid-vivid-vx.y.z-x86_64-unknown-linux-musl
# sudo cp vivid /usr/local/bin
export LS_COLORS="$(vivid generate iceberg-dark)"

## Emacs ライクなキーバインドに設定
bindkey -e

## ターミナルのタイトル設定
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            # send terminal emulator's window name, tmux pane name.
            echo -ne "\033]0;${LOGNAME}@${HOST%%.*}:${PWD}\007"
            local _cup=${$(pwd)/#\/home\/$USER/"~"}
            local _dash=""
            # set an omit string
            [ ${#_cup} -gt 23 ] && _dash=""
            
            RPROMPT="%F{cyan} %f${_dash}${_cup: -23}%F{cyan} %f"
        }
        ;;
esac 

## Alias
alias sudo='sudo '
alias ..='cd ..;'
alias vi='/usr/local/bin/vim'
alias ls='/bin/ls -p --color=auto'
alias ll='/bin/ls -alF --color=auto'
alias l.='/bin/ls -d .* --color=auto'
alias ll.='/bin/ls -dl .* --color=auto'
alias diff='/usr/bin/colordiff'

# alias pip='function _pip(){
#     if [ $1 = "search" ]; then
#         pip_search "$2";
#     else pip "$@";
#     fi;
# }; _pip'

## Disable Commands
disable r

## vimpager
# - Install
# git clone https://github.com/rkitover/vimpager.git
# cd vimpager
# sudo make install
export PAGER=/usr/local/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

## Prompt
### Color
C_SCL="%F{yellow}"          # for using Software Collection Library
C_BRACKETS="%F{cyan}"       # left/right brackets color
C_ROOT="%F{red}"            # '#' prompt color for Root
C_USER="%F{yellow}"         # '%' prompt color for Users
C_HOST="%F{white}"          # hostname color
C_RESET="%f%k"              # fore/back ground color reset
BRAKETS=""

### for Software Collections
if [ ${X_SCLS} ]; then
    SCL="${C_SCL}[SCL]${C_RESET} "
else
    SCL=""
fi

### Define Prompt
case ${UID} in
    0)
        PROMPT='${SCL}${C_BRACKETS}${BRAKETS:0:1}[${C_HOST}%m${C_BRACKETS}]${BRAKETS:1:1} ${C_ROOT}%#${C_RESET} '
        ;;
    *)
        PROMPT='${SCL}${C_BRACKETS}${BRAKETS:0:1}[${C_HOST}%m${C_BRACKETS}]${BRAKETS:1:1} ${C_USER}%#${C_RESET} '
        ;;
esac

## functions
# function formatted_path {
#     local dash="";
#     a=$(tmux display-message -p "#{pane_title}" | sed -r "s/^.+?:(.+)$/\1/")
#     [ ${#a} -gt 23 ] && _dash=""
#     a=${a/#\/home\/$USER/"~"}
#     b=${a: -23}
#     echo "${_dash}${b}"
# }

## tmux session auto attach
if [[ ${UID} -ne 0 ]]; then
    PERCOL=~/.zplug/bin/fzf
    if [[ ! -n $TMUX && $- == *l* ]]; then
        create_new_session="Create New Session"
        start_terminal_normally="Start terminal normally"
        
        # get the IDs
        ID="$(tmux list-sessions)"
        
        if [[ -z "$ID" ]]; then
            ID="${start_terminal_normally}\n${create_new_session}:"
        else
            ID="$ID\n${start_terminal_normally}\n${create_new_session}:"
        fi
        
        ID="`echo $ID | $PERCOL | cut -d: -f1`"
        case "$ID" in
            "${create_new_session}" )
                tmux new-session
                ;;
                
            "${start_terminal_normally}" )
                :   # through
                ;;
                
            [0-9]* )
                tmux attach-session -t "$ID"
                ;;
                
            * )
                :   # through
                ;;
        esac
    fi
fi

## zplug が無ければインストール
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

### zplug Load
source ~/.zplug/init.zsh

### 使用するプラグインを宣言
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh
# zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "junegunn/fzf", \
    from:github, \
    as:command, \
    use:bin/fzf, \
    hook-build:"$ZPLUG_HOME/repos/junegunn/fzf/install --all"

### 使用するプラグインが存在しなければインストール
# fzf インストール時はしばし待つ
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

### plugin を読み込んでパスを通す
zplug load --verbose

## Plugin settings
### fzf を使用する
export FZF_DEFAULT_OPTS="--height 40% --border"
export FZF_TMUX_OPTS="-x 20 -p 80%"               # 80% サイズのポップアップで表示する
export FZF_COMPLETION_TRIGGER='^^'          # ^^[Tab] で fzf を使用する

if [ $TMUX ]; then                          # tmux 上では fzf-tmux を使うようにする
    export FZF_TMUX=1
else
    export FZF_TMUX=0
fi

### enhancd の設定
export ENHANCD_FILTER=fzf-tmux:fzf
export ENHANCD_DISABLE_DOT=1        # "cd .." で enhancd を使用 0:する 1:しない
# export ENHANCD_DISABLE_HOME=1       # 引数無しの cd でインタラクティブフィルターを使用 0:する 1:しない

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
