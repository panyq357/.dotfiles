
-- vim-plug in lua
local Plug = vim.fn['plug#']
vim.call("plug#begin")
    Plug("neovim/nvim-lspconfig")
    Plug("ellisonleao/gruvbox.nvim")
    Plug("ojroques/nvim-osc52")
    Plug("luochen1990/rainbow")
    Plug("mechatroner/rainbow_csv")
    Plug("vim-python/python-syntax")
    Plug("Vimjas/vim-python-pep8-indent")
vim.call("plug#end")

-- gruvbox.nvim
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

-- nvim-osc52
function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '"' then
    require('osc52').copy_register('"')
  end
end
vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

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

