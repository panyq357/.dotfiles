-- Simplify movement among windows.
vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Swapping buffers.
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>", ":bdelete<CR>", { noremap = true, silent = true, nowait = true })

-- Prevent comma <C-c> combination lost comma. In this case, change the behavior of <C-c> in insert mode to act as <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
