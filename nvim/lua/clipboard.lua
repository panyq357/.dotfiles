-- Disable nvim clipboard passing to tmux.
vim.opt.clipboard = ""

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local event = vim.v.event
    if event.operator == "y" and event.regname == "" then
      -- Check nvim/share/nvim/runtime/lua/vim/ui/clipboard/osc52.lua
      -- Note: copy is a function factory.
      local osc52_fun = require("vim.ui.clipboard.osc52").copy(event.regname)
      osc52_fun(event.regcontents)
    end
  end,
})
