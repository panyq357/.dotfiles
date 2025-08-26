vim.lsp.enable('r_language_server')
vim.lsp.enable('pylsp')
vim.lsp.enable('jdtls')


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.api.nvim_create_user_command('LspFormat', function() vim.lsp.buf.format({ async = true }) end, { desc = "LSP Format" })
  end,
})



vim.api.nvim_create_user_command('XMLFormat', function()
  vim.cmd([[ %!xmlstarlet fo --omit-decl % ]])
end, {})

vim.api.nvim_create_user_command('JSONFormat', function()
  vim.cmd([[ %!python3 -m json.tool ]])
end, {})

local function java_action_organize_imports()
  local offset_encoding = 'utf-16'
  local params = vim.lsp.util.make_range_params(0, offset_encoding)
  vim.lsp.buf_request(0, 'java/organizeImports', params, function(err, resp, ctx)
    if err then
      print('OrganizeImport error: ' .. err.message)
      return
    end
    if resp then
      vim.lsp.util.apply_workspace_edit(resp, offset_encoding)
      print('OrganizeImport success.')
    end
  end)
end

vim.api.nvim_create_user_command('JavaOrganizeImports', java_action_organize_imports, {})
