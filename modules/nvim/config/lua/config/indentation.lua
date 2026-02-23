-- Global Settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.indentexpr = ""
vim.opt.autoindent = true

-- Plygins may set indentation implicitly.
-- Set indentation again to overwrite.
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
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "html", "css", "javascript", "javascriptreact", "yaml", "json", "markdown", "yaml", "ruby", "r", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "snakemake" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})

