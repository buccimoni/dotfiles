# dotfiles etc...

dotfile や vim などの設定ファイル置き場

## 下準備
### vivid のインストール
LS_COLORS を簡単に切り替えることが出来る vivid をインストールしておく。

https://github.com/sharkdp/vivid/releases

上記リポジトリより arch に合ったバイナリを使用する。

- `x86_64      : vivid-vx.y.z-x86_64-unknown-linux-musl.tar.gz`
- `arm (32bit) : vivid-vx.y.z-arm-unknown-linux-musleabihf.tar.gz`

展開した中にある `vivid` を `/usr/local/bin` 等、パスの通ったところにインストール。

### fzf のインストール

1. fzf を ~/.fzf に clone して install を実行する。

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Vim plugin manager のインストールと設定

1. plug.vim を所定位置に clone する。

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

2. vim を起動してインストールコマンドを入力する。

```
vim
:PlugInstall
```

## 使い方

clone したディレクトリにリンクを張るなり cp して使う。  
既存の物を上書きするのであれば `ln -nfs` にする。

```
SRC=/path/to/dotfiles
ln -s $SRC/.fzf ~/
ln -s $SRC/.vim{,rc} ~/
ln -s $SRC/.tmux{,.conf} ~/
ln -s $SRC/.z{sh{env,rc},profile} ~/
```


