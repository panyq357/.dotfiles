-- Simplify movement among windows.
vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Swapping buffers.
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":bprev<CR>", { noremap = true, silent = true })

-- A slightly complex buffer-closing shortcut compatible with nvim-tree.
local save_before_close_buffer = function()

  local force_close_buffer = function ()
    -- Get opened buffer number by counting :ls output lines.
    local buf_num = #vim.split(vim.trim(vim.fn.execute("ls")), "\n")
    if buf_num > 1 then
      vim.cmd("bp")
      vim.cmd("bd!#")
    else
      vim.cmd("bd!")
    end
  end

  if vim.bo.modified then
    vim.api.nvim_echo({{"Buffer unsaved, save before close? (y/n/c)", "Question"}}, false, {})

    local ok, choice = pcall(function()
      return vim.fn.nr2char(vim.fn.getchar()):lower()
    end)
    if not ok then return end

    if choice == "y" then
      vim.cmd("w")
      force_close_buffer()
      vim.api.nvim_echo({{"Saved and closed", "None"}}, false, {})
    elseif choice == "n" then
      force_close_buffer()
      vim.api.nvim_echo({{"Closed w/o save", "None"}}, false, {})
    else
      vim.api.nvim_echo({{"Cancelled", "None"}}, false, {})
    end
  else
    force_close_buffer()
  end
end
vim.keymap.set("n", "<C-w>", save_before_close_buffer, { noremap = true, silent = true, nowait = true })

-- Prevent comma <C-c> combination lost comma. In this case, change the behavior of <C-c> in insert mode to act as <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- LSP shortcuts.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
})

-- Completion of file path relative to current file.
local function expand_current_dir_complete()

  local old_dir = vim.fn.getcwd()
  local new_dir = vim.fn.expand('%:p:h')

  vim.cmd('lcd ' .. vim.fn.fnameescape(new_dir))

  vim.api.nvim_input("<C-X><C-F>")

  -- Delay lcd back untile completion complete.
  vim.schedule(function()
    vim.cmd('lcd ' .. vim.fn.fnameescape(old_dir))
  end)
end
vim.keymap.set('i', '<C-X><C-R>', expand_current_dir_complete, { noremap = true, silent = true })
