-- global settings

-- keymap shortcuts
keymap = vim.api.nvim_set_keymap
keymap_opts = { noremap = true, silent = true }

-- packer plugin list
require('packer').startup(function(use)
    use { "wbthomason/packer.nvim" }                  -- packer.nvim must in here
    use { "ellisonleao/gruvbox.nvim" }
    use { "ojroques/nvim-osc52" }
    use { "neovim/nvim-lspconfig" }
    use { "akinsho/bufferline.nvim", tag = "v3.*" }
end)


-- plugin settings

-- ellisonleao/gruvbox.nvim
vim.o.background = "dark"                             -- or "light" for light mode
require("gruvbox").setup({ italic = true })          -- setup must be called before loading the colorscheme
vim.cmd("colorscheme gruvbox")

-- ojroques/nvim-osc52
function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
    require('osc52').copy_register('"')
  end
end
vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

-- neovim/nvim-lspconfig
require("lspconfig").r_language_server.setup({})
require("lspconfig").pyright.setup({})

-- akinsho/bufferline.nvim
require("bufferline").setup({
    options = {
       show_buffer_icons = false,
       show_buffer_close_icons = false,
       show_close_icon = false,
       modified_icon = "[+]",
    },
})

