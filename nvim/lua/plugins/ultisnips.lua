return {
  "SirVer/ultisnips",
  config = function()
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsSnippetDirectories = {
        vim.fn.expand("~/.config/nvim/UltiSnips")
      }
  end
}
