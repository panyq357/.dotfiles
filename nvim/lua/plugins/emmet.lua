return {
  "mattn/emmet-vim",
  config = function()
    -- Prevent emmet-vim from using nvim-treesitter
    -- The `nvim-treesitter.ts_utils` module that emmet-vim relies on
    -- no longer exists in the main branch of nvim-treesitter.
    require('emmet_utils').get_node_at_cursor = function() return nil end
  end
}
