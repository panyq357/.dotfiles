return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim'
  },
  config = function()

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    -- Replace native LSP functions.
    vim.keymap.del('n', 'gra')
    vim.keymap.del('x', 'gra')
    vim.keymap.del('n', 'gri')
    vim.keymap.del('n', 'grn')
    vim.keymap.del('n', 'grr')
    vim.keymap.del('n', 'grt')
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        vim.keymap.del('n', 'gr', { buffer = args.buf })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Telescope LSP reference' })
      end,
    })
  end
}
