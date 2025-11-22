return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  config = function()

    local textobjects = require("nvim-treesitter-textobjects")
    local select = require("nvim-treesitter-textobjects.select")

    textobjects.setup {}

    vim.keymap.set({ "x", "o" }, "ap", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ip", function()
      select.select_textobject("@parameter.inner", "textobjects")
    end)
  end
}
