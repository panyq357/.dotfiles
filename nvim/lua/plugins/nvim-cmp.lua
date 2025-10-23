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

    -- Show completion menu and select first one.
    -- If already showed, confirm selection and trigger again.
    local function complete_select_first(option)
      return function(fallback)
        if cmp.visible() then
          local ok = cmp.confirm(option)
          if not ok then
            fallback()
          else
            complete_select_first()
          end
        else
          local ok = cmp.select_next_item(option)
          if not ok then
            local release = cmp.core:suspend()
            fallback()
            vim.schedule(release)
          end
        end
      end
    end

    cmp.setup({
      completion = {
        autocomplete = false,  -- Disable auto pop up.
      },
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)  -- Use UltiSnips as snippet engine.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = function(fallback) fallback() end,
        ['<C-n>'] = function(fallback) fallback() end,
        ['<C-x><C-o>'] = complete_select_first(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.select_next_item
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' }, -- For ultisnips users.
      })
    })
  end
}
