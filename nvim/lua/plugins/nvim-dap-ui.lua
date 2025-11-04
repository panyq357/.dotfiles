return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    vim.keymap.set("n", "<leader>du", function()
      require("dapui").toggle()
    end, { desc = "Toggle DAP UI" })
  end
}

