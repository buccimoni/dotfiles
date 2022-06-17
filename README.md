# dotfiles etc...
dotfile や vim などの設定ファイル置き場

## Usage
clone したディレクトリにリンクを張って使う。
既存の物を上書きするのであれば `ln -nfs` にする。

```
SRC=/path/to/dotfiles
ln -s $SRC/.fzf ~/
ln -s $SRC/.vim{,rc} ~/
ln -s $SRC/.tmux{,.conf} ~/
ln -s $SRC/.zsh{env,rc} ~/
ln -s $SRC/.zprofile ~/
```

## vim setting
1. Install Plugins

```
:PlugInstall
```

## fzf setting
1. Install fzf

```
~/.fzf/install
```
