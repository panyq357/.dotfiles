vim.opt.compatible = false                    -- Stop vim from act like vi.
vim.opt.number = true                         -- Show line number on the left.
vim.opt.ruler = true                          -- Show cursor position in status line
vim.opt.foldenable = false                    -- Disable code chunk folding by default.

vim.opt.wrap = true                           -- Enable line wrapping. (tips: use 'gk' 'gj' to navigate)
vim.opt.hidden = true                         -- Switch buffers before saving.
vim.opt.hlsearch = true                       -- Highlight all search results.
vim.opt.incsearch = true                      -- Highlight when typing
vim.opt.backspace = ""                        -- Don't backspace over last line.
vim.opt.shiftround = true                     -- Round indent to multiple of 'shiftwidth'.

vim.opt.wildmenu = true                       -- Display a vertical menu when doing tab autocomplete.
vim.opt.wildmode = "longest:full,full"        -- Extend to longest common string, show matches, press <TAB> again to do more completion.

vim.opt.clipboard = "unnamedplus"             -- Syncronize unnamed register with "+" register.
vim.opt.mouse = "nv"
vim.opt.startofline = false                   -- Save cursor position when switching buffer.

vim.opt.updatetime = 200                      -- Millisecond for vim-gitgutter to refresh.
vim.opt.list = true
vim.opt.listchars = "nbsp:!"                  -- Show nbsp as "!"
vim.opt.guicursor = "a:block"                 -- Set cursor in all mode to be block shape.
