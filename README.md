# dotfiles etc...

dotfile や vim などの設定ファイル置き場

## 下準備
### フォントのインストール

使用しているアイコンの表示には Nerd Font が必須なので、  
任意の Nerd Font を使用環境に合わせてインストールしておく。

### Sheldon のインストール
Plugin manager として Sheldon を使用しているのでインストールしておく。

```
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
```

### vivid のインストール

LS_COLORS を簡単に切り替えることが出来る vivid をインストールしておく。

https://github.com/sharkdp/vivid/releases

上記リポジトリより arch に合ったバイナリを使用する。

- `x86_64      : vivid-vx.y.z-x86_64-unknown-linux-musl.tar.gz`
- `arm (32bit) : vivid-vx.y.z-arm-unknown-linux-musleabihf.tar.gz`
- `Ubuntu      : sudo apt install vivid`

展開した中にある `vivid` をパスの通ったところに入れておく。

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
必要に応じて既存のファイルはバックアップしておくと良い。

### 使用例

```
cd /path/to/any
git clone --recursive https://github.com/buccimoni/dotfiles.git
ln -s .vim{,rc} ~/
ln -s .tmux{,.conf} ~/
ln -s .z{sh{env,rc},profile} ~/
ln -s plugins.toml ~/.config/sheldon/plugins.toml
```

