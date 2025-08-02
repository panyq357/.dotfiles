-- vim-plug in lua
local Plug = vim.fn['plug#']
vim.call("plug#begin")
  Plug("neovim/nvim-lspconfig")
  Plug("ellisonleao/gruvbox.nvim")
  Plug("luochen1990/rainbow")
  Plug("mechatroner/rainbow_csv")
  Plug("vim-python/python-syntax")
  Plug("airblade/vim-gitgutter")
  Plug('romainl/vim-cool')
  Plug("snakemake/snakemake", {rtp = "misc/vim"})
  Plug('akinsho/bufferline.nvim', { tag= '*' })
  Plug('neovim/nvim-lspconfig')
vim.call("plug#end")


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
