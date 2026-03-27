-- Disable nvim clipboard passing to tmux.
vim.opt.clipboard = ""


local function osc52(text)
  -- Check line 16-18 in '/opt/homebrew/share/nvim/runtime/lua/vim/ui/clipboard/osc52.lua'.
  vim.api.nvim_chan_send(2, "\27]52;c;" .. vim.base64.encode(text) .. "\7")
end


-- Put plain yank in osc52.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local event = vim.v.event
    if event.operator == "y" and event.regname == "" then
      osc52(table.concat(event.regcontents, "\n"))
    end
  end,
})
