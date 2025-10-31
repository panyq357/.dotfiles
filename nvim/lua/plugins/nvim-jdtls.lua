return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "mason-org/mason-lspconfig.nvim"
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local jdtls = require("jdtls")
        local home = os.getenv("HOME")
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

        local config = {
          cmd = {
            home .. "/.local/share/nvim/mason/packages/jdtls/bin/jdtls",
            "-data", workspace_dir
          },
          root_dir = require("jdtls.setup").find_root({ "gradlew", "mvnw", ".git" }),
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.Assert.*",
                  "org.mockito.Mockito.*",
                },
              },
            },
          },
          init_options = { bundles = {} }
        }
        jdtls.start_or_attach(config)
      end,
    })
  end
}

