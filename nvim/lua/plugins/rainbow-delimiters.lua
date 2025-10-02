return {
  "hiphish/rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = 'rainbow-delimiters.strategy.global',
        },
        query = {
            [''] = 'rainbow-delimiters',
        },
        priority = {
            [''] = 110,
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        }
    }
  end
}
