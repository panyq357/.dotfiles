return {
  "SirVer/ultisnips",
  config = function()
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = ""
    vim.g.UltiSnipsSnippetDirectories = {
        vim.fn.expand("~/.config/nvim/UltiSnips")
      }
  end
}
