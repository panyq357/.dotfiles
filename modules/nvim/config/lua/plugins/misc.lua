return {
  { "romainl/vim-cool" },  -- automaticly :noh after moving cusor.
  { "mechatroner/rainbow_csv" },
  { "mcchrish/nnn.vim" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require('nvim-highlight-colors').setup()
    end
    -- Color Test: #558817, #a8660d
  }
}
