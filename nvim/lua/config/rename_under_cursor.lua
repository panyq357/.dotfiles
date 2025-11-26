local function rename_under_cursor()

  local old_text = vim.fn.expand("<cfile>")
  local old_path = vim.fn.findfile(old_text)

  if old_path == "" then
    vim.notify("No file under cursor.")
    return
  end

  local path_start_pos, path_end_pos = string.find(old_path, old_text, 1, true)

  if not path_start_pos then
    return
  end

  local path_front = old_path:sub(1, path_start_pos-1)
  local path_end = old_path:sub(path_end_pos+1)

  local new_text = vim.fn.input("Change File path: ", old_text)

  local new_path = path_front .. new_text .. path_end

  local new_path_dir = vim.fn.fnamemodify(new_path, ":h")

  if vim.fn.isdirectory(new_path_dir) ~= 1 then
    vim.notify("Directory: " .. new_path_dir .. " not exists, created.")
    vim.fn.mkdir(new_path_dir, "p")
  end

  vim.fn.rename(old_path, new_path)

  local row_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  local old_line = vim.api.nvim_buf_get_lines(0, row_num, row_num + 1, false)[1]
  local line_start_pos, line_end_pos = string.find(old_line, old_text, 1, true)
  local line_front = old_line:sub(1, line_start_pos-1)
  local line_end = old_line:sub(line_end_pos+1)

  local new_line = line_front .. new_text .. line_end

  vim.api.nvim_buf_set_lines(0, row_num, row_num + 1, false, { new_line })
end

vim.api.nvim_create_user_command("RenameUnderCursor", rename_under_cursor, {})
