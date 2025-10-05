return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "ellisonleao/gruvbox.nvim",
    "mcchrish/nnn.vim"  -- for Open nnn here keymap.
  },
  config = function()
    require("nvim-tree").setup {
      actions = {
        change_dir = {
          enable = false
        }
      },
      filters = {
        enable = true,
        git_ignored = false,
        dotfiles = true
      },
      renderer = {
        icons = {
          glyphs = {
            -- git = {
            --   unstaged = "",
            --   staged = "+",
            --   unmerged = "",
            --   renamed = "",
            --   untracked = "󰓎",
            --   deleted = "󰛌",
            --   ignored = "◌",
            -- },
          },
          git_placement = "before"
        }
      },
      on_attach = function(bufnr)

        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "a", api.fs.create, opts("Create file or directory"))
        vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
        vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "x",
          function()
            local node = api.tree.get_node_under_cursor()
            if (node.open) then
              api.node.collapse(node)
            else
              api.node.collapse(node.parent)
            end
          end,
          opts("Collapse folder")
        )
        vim.keymap.set("n", "u",
          function()
            api.tree.change_root_to_parent(api.tree.get_node_under_cursor())
          end,
          opts("Move the tree root up one directory")
        )
        vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("Change working directory to node"))
        vim.keymap.set("n", "CD",
          function()
            api.tree.change_root(vim.fn.getcwd())
          end,
          opts("Change to working directory")
        )
        vim.keymap.set("n", "I", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
        vim.keymap.set("n", "N", function()

          local node = api.tree.get_node_under_cursor()
          local path
          if node then
            path = node.type == "directory" and node.absolute_path or node.parent.absolute_path
          else
            path = vim.fn.getcwd()
          end

          vim.cmd("NnnPicker " .. path)

          end,
          opts("Open nnn here")
        )

      end
    }
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end
}
