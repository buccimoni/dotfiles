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

" view の自動保存
autocmd BufWinLeave ?* silent mkview
autocmd BufWinEnter ?* silent loadview

"" statusline
set laststatus=2                " Statusline を常時表示する
"set statusline=%F\ %m%r%h%w\ %<[%Y]\ [%{&fileencoding}]\ [%{&ff}]\ %=[CODE\:0x%02B]\ [%02v,%l/%L]

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
" Space-h と l で行頭と行末に移動するようにする
nnoremap <Space>h ^
nnoremap <Space>l $
" Normal/Visual モード時に C-k でコメントアウトをトグルする
nmap <C-k> <plug>(caw:hatpos:toggle)
vmap <C-k> <plug>(caw:hatpos:toggle)

"" Theme
colorscheme iceberg
set background=dark

"" Plug と使用する plugin を記述
call plug#begin()
Plug 'vim-jp/vimdoc-ja'                 " Help in japanese
Plug 'cocopon/iceberg.vim'              " (theme) Iceberg
Plug 'tomasr/molokai'                   " (theme) molokai
Plug 'vim-airline/vim-airline'          " (statusline) airline
Plug 'vim-airline/vim-airline-themes'   " (statusline) airline
Plug 'gkeep/iceberg-dark'               " (statusline) iceberg dark (airline theme)
Plug 'ryanoasis/vim-devicons'           " use Nerd Fonts
Plug 'chr4/nginx.vim'                   " (completion) Nginx 
Plug 'tyru/caw.vim'                     " (edit) Comment Plugin
Plug 'nathanaelkane/vim-indent-guides'  " add indent guide line.
Plug 'osyo-manga/vim-over'              " subsutitue highlighter
call plug#end()

"" Help Setting
set helplang=ja,en
 
"" Airline Settings
let g:airline_theme='icebergDark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=0
set ttimeoutlen=50
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

"" vim indent guides Settings
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1e2132 ctermbg=17
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2e313f ctermbg=18

"" vim-over Settings
nnoremap <silent> <Space>s :OverCommandLine<CR>%s//g<Left><Left>
vnoremap <silent> <Space>s :OverCommandLine<CR>s//g<Left><Left>

