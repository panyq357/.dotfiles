set nocompatible                                      " Stop vim from act like vi.
set number                                            " Show line number on the left.
set ruler                                             " Show cursor position in status line
set wildmenu                                          " Display a horizontal menu when doing tab autocomplete.
set tabstop=4                                         " Show existing tab with 4 spaces width.
set expandtab                                         " On pressing tab, insert 4 spaces.
set shiftwidth=4                                      " When indenting with '>', use 4 spaces width.
set nofoldenable                                      " Disable code chunk folding by default.
set nowrap                                            " Stop vim from wrapping lines that exceed screen border.
set hidden                                            " Switch buffers before saving.
set directory=$HOME/.vim/swapfiles//                  " Set swap file dir.
set backspace=                                        " Don't backspace over last line.

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
Plug 'glench/vim-jinja2-syntax'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'chr4/nginx.vim'                              " Nginx syntax highlight.
Plug 'luochen1990/rainbow'                         " Rainbow parentheses.

" Initialize plugin system
call plug#end()

" After loading plugins, vim-plug will automatically execute these:
"
"     filetype plugin indent on
"     syntax enable
"
" and some plugins may automaticlly set some settings too.
"
" So to overwrite, commands also must be added in below.
" ------------------------------

" ---------- Indent Settings ----------
filetype indent off  " Turn off filetype based indent (no 'indentexpr' will be setted automatically).
set autoindent       " Keep indentation of new line the same as previous line.

" Settings for HTML and related template languages.
function SetHTMLOptions()
    setlocal ts=2 sw=2
    filetype indent on  " Turn on autoindent for 'gg=G' global indentation.
endfunction
autocmd Filetype html,htmldjango,jinja.html call SetHTMLOptions()  " jinja.html was provided by glench/vim-jinja2-syntax plugin.
let g:html_indent_attribute = 1

" After snakemake plugin recognized a snakemake file and setted 'indentexpr', overwrite it.
autocmd Filetype snakemake set indentexpr=
" ---------------------------------------

" ---------- gruvbox ----------
set cursorline
set termguicolors
set background=dark
colorscheme gruvbox
" -----------------------------

" ---------- vim-oscyank ----------
" automatically yank to clipbroad
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
