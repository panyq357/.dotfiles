vim.lsp.config['r_language_server'] = {
  cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
  filetypes = { 'r' },
  root_dir = vim.fn.getcwd(),
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil  -- Disable LSP's hightlight, native is better.
  end
}
vim.lsp.enable('r_language_server')

vim.lsp.config['pyright'] = {
  cmd =  { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json'
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
vim.lsp.enable('pyright')
