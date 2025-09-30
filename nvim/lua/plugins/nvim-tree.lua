return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "ellisonleao/gruvbox.nvim"
  },
  config = function()
    require("nvim-tree").setup()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end
}
