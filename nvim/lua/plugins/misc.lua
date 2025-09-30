return {
  { "romainl/vim-cool" },
  {
    "vim-python/python-syntax",
    config = function()
      vim.g.python_highlight_all = 1
    end
  },
  {
    "snakemake/snakemake",
    ft = "snakemake",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/misc/vim")
    end,
    init = function(plugin)
      require("lazy.core.loader").ftdetect(plugin.dir .. "/misc/vim")
    end,
  },
  { "mechatroner/rainbow_csv" },
  { "mcchrish/nnn.vim" },
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
    -- Color Test: #558817, #a8660d
  }
}
