set encoding=utf-8
set nobackup
set noswapfile
set noundofile
set showcmd
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

" statusline
set laststatus=2
set statusline=%F\ %m%r%h%w\ %<[%{&fileencoding}]\ [%{&ff}]\ %=[CODE\:0x%02B]\ [%02v,%l/%L]

" True colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set incsearch
set wrapscan
set hlsearch
" highlight clear
nnoremap <ESC><ESC> :nohlsearch<CR>
" display line
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
syntax enable

" Theme
colorscheme iceberg
set background=dark
