-- Disable nvim clipboard passing to tmux.
vim.opt.clipboard = ""


local function osc52(text)
  io.write("\27]52;c;" .. vim.base64.encode(text) .. "\7")
  io.flush()
end


-- Put plain yank in osc52.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local event = vim.v.event
    if event.operator == "y" and event.regname == "" then
      -- Check nvim/share/nvim/runtime/lua/vim/ui/clipboard/osc52.lua
      -- Note: copy is a function factory.
      osc52(table.concat(event.regcontents, "\n"))
    end
  end,
})
