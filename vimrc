" ---------- Options ----------
set nocompatible                                      " Stop vim from act like vi.
set number                                            " Show line number on the left.
set ruler                                             " Show cursor position in status line
set nofoldenable                                      " Disable code chunk folding by default.
set wrap                                              " Enable line wrapping. (tips: use 'gk' 'gj' to navigate)
set hidden                                            " Switch buffers before saving.
set is hls                                            " Highlight all search results.
set backspace=                                        " Don't backspace over last line.
set shiftround                                        " Round indent to multiple of 'shiftwidth'.

set wildmenu                                          " Display a menu when doing tab autocomplete in command mode.
set wildmode=longest:full,full                        " Extend to longest common string, show matches, press <TAB> again to do more completion.
set wildoptions=pum                                   " Display vertical menu.

set directory=${HOME}/.vim/swap//                     " Set swap file dir.
call mkdir($HOME . "/.vim/swap", "p", 0700)           " Create ~/.vim/swap in case it does not exists.
set list listchars=nbsp:!                             " Show nbsp as !
" -----------------------------

" ---------- Key Mappings ----------
" Simplify movement among windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" Prevent comma <C-c> combination lost comma
inoremap <C-c> <Esc>

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
" ----------------------------------

" ---------- vim-plug ----------
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'mattn/emmet-vim'
Plug 'ap/vim-buftabline'

" Syntax
Plug 'vim-python/python-syntax'
Plug 'chr4/nginx.vim'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'luochen1990/rainbow'  " Rainbow parentheses.
Plug 'mechatroner/rainbow_csv'

" LSP
Plug 'prabirshrestha/vim-lsp'

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
set et ts=4 sw=0 sts=0 nocin nosi inde= ai                    " Default settings.
autocmd Filetype *
    \ setlocal et ts=4 sw=0 sts=0 nocin nosi inde= ai         " Override all other indent settings, keep only autoindent.
autocmd Filetype html,css,javascript,json,markdown,yaml,ruby
    \ setlocal ts=2                                           " Shrink indent width in some languages.
autocmd FileType make set noet                                " Use TAB in makefile.
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

" ---------- Relative Path Settings ----------
" function AddCurrentFileDirToPath()
"     let $cfd = expand("%s:h")
"     setlocal path+=$cfd
" endfunction
" autocmd BufEnter Snakefile,*.smk call AddCurrentFileDirToPath()
" --------------------------------------------

" ---------- LSP ----------
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

let g:lsp_signature_help_enabled = 0
let g:lsp_completion_documentation_enabled = 0
let g:lsp_diagnostics_enabled = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" -------------------------
