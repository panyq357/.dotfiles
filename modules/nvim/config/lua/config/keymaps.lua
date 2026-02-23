-- Tip: Use `:put =execute('map')` to insert all existing keymap to current file for search.

-- Simplify movement among windows.
vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Swapping buffers.
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":bprev<CR>", { noremap = true, silent = true })

-- Close buffer after save.
vim.keymap.set("n", "<C-w>", require("util.buffer").open_former_then_close, { noremap = true, silent = true, nowait = true })

-- Prevent comma <C-c> combination lost comma. In this case, change the behavior of <C-c> in insert mode to act as <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- LSP shortcuts.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  end,
})
