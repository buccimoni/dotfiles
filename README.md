# dotfiles etc...

dotfile や vim などの設定ファイル置き場

## 下準備
### vivid のインストール
LS_COLORS を簡単に切り替えることが出来る vivid をインストールしておく。

https://github.com/sharkdp/vivid/releases

上記リポジトリより arch に合ったバイナリを使用する。

- `x86_64      : vivid-vx.y.z-x86_64-unknown-linux-musl.tar.gz`
- `arm (32bit) : vivid-vx.y.z-arm-unknown-linux-musleabihf.tar.gz`
- `Ubuntu      : sudo apt install vivid`

展開した中にある `vivid` をパスの通ったところに入れておく。

### fzf のインストール

`~/.fzf` に clone して install を実行する。

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

### vimpager のインストール

clone して sudo make install する。

```
git clone https://github.com/rkitover/vimpager.git
cd vimpager
sudo make install
```

## 使い方

clone したファイルやディレクトリにリンクを張るなりコピーして使う。  
.tmux/ と .vim/ は適当に待避しておくこと。  
既存の物を上書きするのであれば `ln -nfs` でも OK。

```
SRC=/path/to/dotfiles
ln -s $SRC/.vim{,rc} ~/
ln -s $SRC/.tmux{,.conf} ~/
ln -s $SRC/.z{sh{env,rc},profile} ~/
```

