return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    outline_window = {
      -- Percentage or integer of columns
      width = 20,
      -- Whether width is relative to the total width of nvim
      -- When relative_width = true, this means take 25% of the total
      -- screen width for outline window.
      relative_width = true,
    },
    symbol_folding = {
      -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
      autofold_depth = 0,
      -- When to auto unfold nodes
      auto_unfold = {
        -- Auto unfold currently hovered symbol
        hovered = false,
        -- Auto fold when the root level only has this many nodes.
        -- Set true for 1 node, false for 0.
        only = true,
      },
    },
  },
}
