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

let mapleader=','                                     " Set leader key.

" ---------- Key Mappings ----------
" Simplify movement among windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch buffers.
" if in NERDTree tab, move to the right first, then switch the buffers.
nnoremap <expr> <C-n> exists("b:NERDTree") ? '<C-w>l:bn<CR>':':bn<CR>'
nnoremap <expr> <C-p> exists("b:NERDTree") ? '<C-w>l:bp<CR>':':bp<CR>'

" Prevent comma <C-c> combination lost comma
inoremap <C-c> <Esc>
" ----------------------------------

" ---------- vim-plug ----------
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-buffer-ops'           " Highlight opened buffers.
Plug 'morhetz/gruvbox'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'glench/vim-jinja2-syntax'
Plug 'ap/vim-buftabline'                           " Add buffer tabline on the top.
Plug 'chr4/nginx.vim'                              " Nginx syntax highlight.
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'mattn/emmet-vim'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'prabirshrestha/vim-lsp'

" Initialize plugin system
call plug#end()
" call plug#end() will automatically execute these:
"     filetype plugin indent on
"     syntax enable
" So to overwrite this behavior, commands must be added below call plug#end()
" ------------------------------

" ---------- Filetype Settings ----------
autocmd Filetype yaml filetype indent off       " disable auto indent in yaml files.

autocmd Filetype html setlocal ts=2 sw=2        " set HTML indent
autocmd Filetype htmldjango setlocal ts=2 sw=2  " set Django & flask indent
let g:html_indent_attribute = 1

set autoindent  " keep indentation of new line the same as previous line
" ---------------------------------------

" ---------- NERDTree ----------
let NERDTreeMinimalUI=1
nnoremap <leader>e :NERDTreeToggle<CR>
" let g:NERDTreeMinimalMenu=1
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeRemoveFileCmd = 'trash '
let g:NERDTreeRemoveDirCmd = 'trash '
" ------------------------------

" ---------- gruvbox ----------
set cursorline
set termguicolors
colorscheme gruvbox
set background=dark
" -----------------------------

" ---------- vim-oscyank ----------
" automatically yank to clipbroad
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
" make vim-oscyank work in tmux 3.3
let g:oscyank_term = 'default'
" -----------------------------

" ---------- vim-lsp ----------
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if system('R --slave -e ''if (system.file(package="languageserver") != "") { cat("yes") } else { cat("no")}''') == "yes"
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rlsp',
        \ 'cmd': {server_info->['R', '--slave', '-e', 'languageserver::run()']},
        \ 'allowlist': ['r'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
    let g:lsp_diagnostics_enabled = 0
	let g:lsp_diagnostics_signs_enabled = 0
	let g:lsp_diagnostics_virtual_text_enabled = 0
	let g:lsp_completion_documentation_enabled = 0     " disable right side docs of omni completion items.
	let g:lsp_signature_help_enabled = 0               " disable pop up function help after typed function name and left bracket.
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" -----------------------------


" Markdown codeblock syntax highlight
let g:markdown_fenced_languages = ['bash', 'python', 'r']

" vim-buftabline
let g:buftabline_indicators = 1
" let g:buftabline_numbers = 1

" python-syntax
let g:python_highlight_all = 1
