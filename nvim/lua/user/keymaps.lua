-- some short cuts
keymap = vim.api.nvim_set_keymap
keymap_opts = { noremap = true, silent = true }


vim.g.mapleader = ","
keymap("n", "<C-h>", "<C-w>h", keymap_opts)
keymap("n", "<C-j>", "<C-w>j", keymap_opts)
keymap("n", "<C-k>", "<C-w>k", keymap_opts)
keymap("n", "<C-l>", "<C-w>l", keymap_opts)
keymap("", "<C-c>", "<Esc>", keymap_opts)
keymap("n", "<C-n>", ":bnext<cr>", keymap_opts)
keymap("n", "<C-p>", ":bprevious<cr>", keymap_opts)
keymap("i", "<C-c>", "<Esc>", keymap_opts)

