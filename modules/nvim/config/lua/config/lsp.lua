-- Install: run `install.packages("languageserver")` in R session.
vim.lsp.config['r_language_server'] = {
  cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
  filetypes = { 'r' },
  root_dir = vim.fn.getcwd(),
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil  -- Disable LSP's hightlight, native is better.
  end
}
vim.lsp.enable('r_language_server')

-- Install: run `npm install -g pyright`.
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

-- Install: run `npm install -g typescript typescript-language-server`
vim.lsp.config['ts_ls'] = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  root_dir = vim.fs.dirname(
    vim.fs.find({ 'tsconfig.json', 'package.json' }, { upward = true })[1]
  ),
}
vim.lsp.enable('ts_ls')
