# dotfiles etc...
dotfile や vim などの設定ファイル置き場

## Usage
clone したディレクトリにリンクを張って使う。

'''
SRC=/path/to/dotfiles
ln -s $SRC/.vim{,rc} ~/
ln -s $SRC/.tmux{,.conf} ~/
ln -s $SRC/.zsh{env,rc} ~/
ln -s $SRC/.zprofile ~/
'''

## vim setting
1. Install Plugins

''':PlugInstall'''

## fzf setting
1. Install fzf

'''
ln -s /path/to/dotfiles/.fzf ~/
~/.fzf/install
'''

