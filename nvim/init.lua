vim.opt.compatible = false                    -- Stop vim from act like vi.
vim.opt.number = true                         -- Show line number on the left.
vim.opt.ruler = true                          -- Show cursor position in status line
vim.opt.foldenable = false                    -- Disable code chunk folding by default.

vim.opt.wrap = true                           -- Enable line wrapping. (tips: use 'gk' 'gj' to navigate)
vim.opt.hidden = true                         -- Switch buffers before saving.
vim.opt.hlsearch = true                       -- Highlight all search results.
vim.opt.incsearch = true                      -- Highlight when typing
vim.opt.backspace = ""                        -- Don't backspace over last line.
vim.opt.shiftround = true                     -- Round indent to multiple of 'shiftwidth'.

vim.opt.wildmenu = true                       -- Display a vertical menu when doing tab autocomplete.
vim.opt.wildmode = "longest:full,full"        -- Extend to longest common string, show matches, press <TAB> again to do more completion.

vim.opt.clipboard = "unnamedplus"             -- Syncronize unnamed register with "+" register.
vim.opt.mouse = "nv"
vim.opt.startofline = false                   -- Save cursor position when switching buffer.

vim.opt.updatetime = 200                      -- Millisecond for vim-gitgutter to refresh.
vim.opt.list = true
vim.opt.listchars = "nbsp:!"                  -- Show nbsp as "!"
vim.opt.guicursor = "a:block"                 -- Set cursor in all mode to be block shape.

-- Keymaps

-- Simplify movement among windows.
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- Swapping buffers.
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':bprev<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<C-w>', ':bdelete<CR>', {noremap = true, silent = true})

-- Prevent comma <C-c> combination lost comma. In this case, change the behavior of <C-c> in insert mode to act as <Esc>
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', {noremap = true, silent = true})


-- vim-plug in lua
local Plug = vim.fn['plug#']
vim.call("plug#begin")
    Plug("neovim/nvim-lspconfig")
    Plug("ellisonleao/gruvbox.nvim")
    Plug("luochen1990/rainbow")
    Plug("mechatroner/rainbow_csv")
    Plug("vim-python/python-syntax")
    Plug("airblade/vim-gitgutter")
    Plug("snakemake/snakemake", {rtp = "misc/vim"})
    Plug('akinsho/bufferline.nvim', { tag= '*' })
vim.call("plug#end")


-- LSP
-- Setup language servers.
-- local lspconfig = require('lspconfig')
-- lspconfig.pylsp.setup {}
-- lspconfig.r_language_server.setup {}
-- 
-- -- Global mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- 
-- -- Use LspAttach autocommand to only map the following keys
-- -- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     -- Enable completion triggered by <c-x><c-o>
--     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
-- 
--     -- Buffer local mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local opts = { buffer = ev.buf }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wl', function()
--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, opts)
--     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<space>f', function()
--       vim.lsp.buf.format { async = true }
--     end, opts)
--   end,
-- })
-- 
-- 
--
--
--

-- Indentation Settings

-- Global Settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.indentexpr = ""
vim.opt.autoindent = true

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "*",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 0
        vim.opt_local.softtabstop = 0
        vim.opt_local.cindent = false
        vim.opt_local.smartindent = false
        vim.opt_local.indentexpr = ""
        vim.opt_local.autoindent = true
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"html", "css", "javascript", "yaml", "json", "markdown", "yaml", "ruby", "r"},
    callback = function()
        vim.opt_local.tabstop = 2
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"make"},
    callback = function()
        vim.opt_local.expandtab = false
    end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"snakemake"},
    callback = function()
        vim.opt_local.commentstring = "# %s"
    end
})
--




-- gruvbox.nvim
vim.o.background = "dark"
vim.cmd("silent! colorscheme gruvbox")


-- bufferline.nvim
vim.opt.termguicolors = true
require("bufferline").setup{
        options = {
            buffer_close_icon = "x"
        }
}


-- see: help clipboard-osc52
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}


-- rainbow
vim.g.rainbow_active = 1
vim.g.rainbow_conf = {
    -- For color names, see: <https://codeyarns.com/tech/2011-07-29-vim-chart-of-color-names.html>
    guifgs = {"firebrick1", "darkorange2", "DodgerBlue3", "BlueViolet"},
}

-- Markdown codeblock syntax highlight
vim.g.markdown_fenced_languages = {'bash', 'python', 'r'}

-- python-syntax
vim.g.python_highlight_all = 1


-- vim-gitgutter
vim.api.nvim_set_hl(0, "SignColumn", {})  -- remove SignColumn background.
