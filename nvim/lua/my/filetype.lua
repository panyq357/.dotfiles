-- Shrink indent width.
vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"html", "css", "javascript", "yaml"},
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

-- Disable auto indent.
vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"yaml"},
    callback = function()
        vim.opt_local.indentexpr = nil
    end
})

-- Indent inside <tag>, see ':help html-indent'.
vim.g.html_indent_attribute = 1  

