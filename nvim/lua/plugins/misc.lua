return {
  { "romainl/vim-cool" },  -- automaticly :noh after moving cusor.
  { "mechatroner/rainbow_csv" },
  { "mcchrish/nnn.vim" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
    -- Color Test: #558817, #a8660d
  }
}
