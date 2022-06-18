# dotfiles etc...
dotfile や vim などの設定ファイル置き場

## 使い方
clone したディレクトリにリンクを張って使う。
既存の物を上書きするのであれば `ln -nfs` にする。

```
SRC=/path/to/dotfiles
ln -s $SRC/.fzf ~/
ln -s $SRC/.vim{,rc} ~/
ln -s $SRC/.tmux{,.conf} ~/
ln -s $SRC/.z{sh{env,rc},profile} ~/
```

## vivid のインストール
LS_COLORS を簡単に切り替えることが出来る vivid をインストールしておく。

https://github.com/sharkdp/vivid/releases

上記リポジトリより arch に合ったバイナリを使用する。

- `x86_64      : vivid-vx.y.z-x86_64-unknown-linux-musl.tar.gz`
- `arm (32bit) : vivid-vx.y.z-arm-unknown-linux-musleabihf.tar.gz`

展開した中にある `vivid` を `/usr/local/bin` 等、パスの通ったところにインストール。

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

