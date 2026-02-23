vim.diagnostic.config({
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = '■',
    spacing = 2
  },
  signs = false,
})

-- Original gruvbox.nvim settings:
--
--   DiagnosticVirtualTextError = { link = "GruvboxRed" },
--   DiagnosticVirtualTextWarn = { link = "GruvboxYellow" },
--   DiagnosticVirtualTextInfo = { link = "GruvboxBlue" },
--   DiagnosticVirtualTextHint = { link = "GruvboxAqua" },
--   DiagnosticVirtualTextOk = { link = "GruvboxGreen" },

local gruvbox = require("gruvbox")

if gruvbox then
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = gruvbox.palette.faded_red })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = gruvbox.palette.faded_yellow })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = gruvbox.palette.faded_blue })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = gruvbox.palette.faded_aqua })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOK", { fg = gruvbox.palette.faded_green })
end
