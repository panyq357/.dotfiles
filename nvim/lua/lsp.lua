vim.lsp.enable("r_language_server")
vim.lsp.enable("pyright")
vim.lsp.enable("jdtls")

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

vim.api.nvim_create_user_command("Format", function()
  local formatters = {
    python = "%! python3 -m autopep8 -",
    json = "%! python3 -m json.tool",
    xml = "%!xmlstarlet fo --omit-decl",
    lua = "%!stylua --indent-type Spaces --indent-width 2 -",
  }

  local cmd = formatters[vim.bo.filetype]

  if cmd then
    vim.cmd(cmd)
  end
end, {})

vim.api.nvim_create_user_command("JavaOrganizeImports", function()
  local offset_encoding = "utf-16"
  local params = vim.lsp.util.make_range_params(0, offset_encoding)
  vim.lsp.buf_request(0, "java/organizeImports", params, function(err, resp, ctx)
    if err then
      print("OrganizeImport error: " .. err.message)
      return
    end
    if resp then
      vim.lsp.util.apply_workspace_edit(resp, offset_encoding)
      print("OrganizeImport success.")
    end
  end)
end, {})
