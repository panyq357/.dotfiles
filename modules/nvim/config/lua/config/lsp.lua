vim.lsp.config['r_language_server'] = {
  cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
  filetypes = { 'r' },
  root_dir = vim.fn.getcwd()
}
vim.lsp.enable('r_language_server')
