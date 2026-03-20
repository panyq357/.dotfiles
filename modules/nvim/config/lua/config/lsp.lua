vim.lsp.config['r_language_server'] = {
  cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
  filetypes = { 'r' },
  root_dir = vim.fn.getcwd(),
  capabilities = {
    textDocument = {
      semanticTokens = nil  -- Disable LSP's hightlight, native is better.
    }
  }
}
vim.lsp.enable('r_language_server')
