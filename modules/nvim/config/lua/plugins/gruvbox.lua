return {
  "ellisonleao/gruvbox.nvim",
  config = function()
    vim.o.background = "dark"
    vim.cmd("silent! colorscheme gruvbox")
    vim.api.nvim_set_hl(0, "SignColumn", {})      -- Remove SignColumn background.
  end
}
