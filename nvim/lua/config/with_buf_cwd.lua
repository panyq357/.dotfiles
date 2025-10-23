-- A decorator for temporarily change working directory relative to current buffer.
local with_buf_cwd = function(fn)
  return function(...)
    local old_dir = vim.fn.getcwd()
    local new_dir = vim.fn.expand('%:p:h')

    vim.cmd('lcd ' .. vim.fn.fnameescape(new_dir))

    local ok, result = pcall(fn, ...)

    -- Delay cd back, to make sure operation done in correct working directory.
    vim.schedule(function()
      vim.cmd("silent! lcd " .. vim.fn.fnameescape(old_dir))
    end)

    if not ok then
      error(result)
    else
      return result
    end
  end
end

-- Completion of file path relative to current file.
vim.keymap.set('i', '<C-X><C-R>', with_buf_cwd(function()
  vim.api.nvim_input("<C-X><C-F>")
  end),
  { noremap = true, silent = true }
)

-- `edit` relative to current buffer file.
vim.api.nvim_create_user_command(
  "BEdit",
  with_buf_cwd(function(opts)
    vim.cmd("edit " .. vim.fn.fnameescape(opts.args))
  end),
  {
    nargs = 1,
    complete = with_buf_cwd(function(arglead)
      return vim.fn.getcompletion(arglead, "file")
    end)
  }
)

-- Run shell command relative to current buffer file.
vim.api.nvim_create_user_command(
  "BShell",
  with_buf_cwd(function(opts)
    vim.cmd("!" .. opts.args)
  end),
  {
    nargs = "+",
    complete = with_buf_cwd(function(arglead)
      return vim.fn.getcompletion(arglead, "file")
    end)
  }
)
