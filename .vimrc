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
" Simplify movement among windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Set leader key
let mapleader=","
" Prevent comma <C-c> combination lost comma
imap <C-c> <Esc>

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" Initialize plugin system
call plug#end()
" call plug#end() will automatically execute these:
"     filetype plugin indent on
"     syntax enable
" So to overwrite this behavior, commands must be added below call plug#end()

" Disable filetype based auto indentation
filetype indent off

" Keep indentation of new line the same as previous line
set autoindent

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

" vim-oscyank, automatically yank from '+' register
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
" make vim-oscyank work in newest version of tmux
let g:oscyank_term = 'default'


