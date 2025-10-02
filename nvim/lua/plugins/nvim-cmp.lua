return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",  -- Attach to LSP after mason-lspconfig complete.
    'hrsh7th/cmp-nvim-lsp',
    'SirVer/ultisnips',
    'quangnguyen30192/cmp-nvim-ultisnips'
  },
  config = function()

    -- Set up nvim-cmp.
    local cmp = require'cmp'
    cmp.setup({
      completion = {
        autocomplete = false,  -- Disable auto pop up.
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true })
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' }, -- For ultisnips users.
      }, {
        { name = 'buffer' },
      })
    })
  end
}
