" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Don't fold!
set nofoldenable 
" Don't break lines!
set nowrap
" Line number
set number
" recursive search path
set path+=**
" Simplify movement among windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Set leader key
let mapleader=","

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'preservim/nerdtree'
Plug 'mechatroner/rainbow_csv'
"Plug 'jpalardy/vim-slime'
Plug 'gruvbox-community/gruvbox'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" Initialize plugin system
call plug#end()

" NERDTree
let NERDTreeMinimalUI=1
nnoremap <leader>e :NERDTreeToggle<CR>

" gruvbox
set cursorline
set termguicolors
colorscheme gruvbox
set background=dark

" Markdown codeblock syntax highlight
let g:markdown_fenced_languages = ['bash', 'python', 'r']

" %>% shortcut
imap <leader>m %>%

" vim-oscyank
vnoremap <leader>c :OSCYank<CR>

