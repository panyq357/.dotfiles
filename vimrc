set nocompatible                                      " Stop vim from act like vi.
set number                                            " Show line number on the left.
set ruler                                             " Show cursor position in status line
set wildmenu                                          " Display a horizontal menu when doing tab autocomplete.
set expandtab                                         " When pressing <Tab>, insert 4 spaces instead '\t'.
set tabstop=4                                         " Press <Tab> insert 4 spaces.
set shiftwidth=4                                      " When pressing '>>', insert 4 spaces.
set nofoldenable                                      " Disable code chunk folding by default.
set wrap                                              " Enable line wrapping. (tips: use 'gk' 'gj' to navigate)
set hidden                                            " Switch buffers before saving.
set backspace=                                        " Don't backspace over last line.

set directory=${HOME}/.vim/swap//                     " Set swap file dir.
call mkdir($HOME . "/.vim/swap", "p", 0700)           " Create ~/.vim/swap in case it does not exists.

" ---------- Key Mappings ----------
" Simplify movement among windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Prevent comma <C-c> combination lost comma
inoremap <C-c> <Esc>
" ----------------------------------

" ---------- vim-plug ----------
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

if has("macunix")
    Plug '/opt/homebrew/opt/fzf'
endif

Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'mattn/emmet-vim'

" Syntax
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'chr4/nginx.vim'
Plug 'luochen1990/rainbow'  " Rainbow parentheses.

" Initialize plugin system
call plug#end()

" After loading plugins, vim-plug will automatically execute these:
"
"     filetype plugin indent on
"     syntax enable
"
" And some plugins may automaticlly set some settings too.
"
" So to overwrite, commands also must be added in below.
" ------------------------------

" ---------- Indent Settings ----------
autocmd Filetype html,css,javascript setlocal ts=2 sw=2  " Shrink indent width in web languages.
let g:html_indent_attribute = 1                          " About indent inside <tag>, see ':help html-indent'.
" ---------------------------------------

" ---------- gruvbox ----------
set cursorline termguicolors background=dark
colorscheme gruvbox
" -----------------------------

" ---------- vim-oscyank ----------
" automatically yank to clipbroad, see ':help event-varaible'.
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
" make vim-oscyank work in tmux 3.3
let g:oscyank_term = 'default'
" -----------------------------

" Markdown codeblock syntax highlight
let g:markdown_fenced_languages = ['bash', 'python', 'r']

" python-syntax
let g:python_highlight_all = 1

" rainbow parentheses
let g:rainbow_active = 1

