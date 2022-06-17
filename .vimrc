"" Basic Settings
set encoding=utf-8              " 文字エンコーディング
set nobackup                    " backup 無効化
set noswapfile                  " swap ファイル無効化
set noundofile                  " Undo ファイル無効化
set showcmd                     " 入力中のコマンドを表示する
set wildmode=list:longest       " ファイル名入力補完をする
set tabstop=4                   " TAB をスペース 4 個分にする
set shiftwidth=4                " Indent 増減をスペース 4 個分にする
set incsearch                   " Incremental Search を使用する
set wrapscan                    " 最後の検索結果の次に先頭に戻る
set hlsearch                    " 検索結果をハイライトする
set ignorecase                  " 検索に大文字小文字を区別しない
set expandtab                   " TAB の文字コードを指定分のスペースにする
set hidden                      " 未保存の Buffer に対する警告を抑制
set modeline                    " modeline を探しに行く行数 (default : 5)
set clipboard+=unnamed          " 自動的に Clipboard を使用する
set backspace=indent,eol,start  " BackSpace の動作を変更する
syntax enable                   " Syntax-hilight する

"" statusline
set laststatus=2                " Statusline を常時表示する
set statusline=%F\ %m%r%h%w\ %<[%Y]\ [%{&fileencoding}]\ [%{&ff}]\ %=[CODE\:0x%02B]\ [%02v,%l/%L]

"" Enable True-color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"" Key settings
" ESC x2 でハイライトを解除する
nnoremap <ESC><ESC> :nohlsearch<CR>
" 表示行で上下カーソル移動するようにする
nnoremap j gj
nnoremap k gk
nnoremap gk k
nnoremap gj j

"" Theme
colorscheme iceberg
set background=dark

"" Plug と使用する plugin を記述
call plug#begin()
Plug 'chr4/nginx.vim'
call plug#end()

