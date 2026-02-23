local M = {}

--- @return boolean buffer_closed
M.save_before_close = function(buf_id, before_close_fn)

  if buf_id == nil then
    buf_id = vim.api.nvim_get_current_buf()
  end

  local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf_id), ":t")

  if before_close_fn == nil then
    before_close_fn = function() end
  end

  local save_buffer = function()
    if vim.api.nvim_buf_is_loaded(buf_id) then
      vim.api.nvim_buf_call(buf_id, function()
        vim.cmd("write")
      end)
    end
  end

  local force_close_buffer = function()
    vim.api.nvim_buf_delete(buf_id, {force = true})
  end

  local is_modified = vim.api.nvim_buf_get_option(buf_id, "modified")

  if (is_modified) then

    vim.api.nvim_echo({{"Buffer unsaved, save before close? (y/n/c): ", "Question"}}, false, {})

    local choice = vim.fn.getcharstr():lower()

    if choice == "y" then
      before_close_fn()
      save_buffer()
      force_close_buffer()
      vim.api.nvim_echo({{"Buffer '" .. buf_name .."' saved and closed", "None"}}, false, {})
      return true;
    elseif choice == "n" then
      before_close_fn()
      force_close_buffer()
      vim.api.nvim_echo({{"Buffer '" .. buf_name .."' closed w/o save", "None"}}, false, {})
      return false;
    else
      vim.api.nvim_echo({{"Cancelled", "None"}}, false, {})
      return false;
    end


  else
    before_close_fn()
    force_close_buffer()
    vim.api.nvim_echo({{"Buffer '" .. buf_name .."' closed", "None"}}, false, {})
    return true;
  end

end


M.get_file_buf_ids = function()
  local file_buf_ids = {}
  for _, id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(id, "buflisted") then
      table.insert(file_buf_ids, id)
    end
  end
  return file_buf_ids
end



M.get_buf_id_by_abs_path = function(abs_path)

  local abs_path_to_id = {}
  for _, id in ipairs(M.get_file_buf_ids()) do
    abs_path_to_id[vim.api.nvim_buf_get_name(id)] = id
  end

  return abs_path_to_id[abs_path]
end


M.open_former_then_close = function(buf_id)

  if buf_id == nil then
    buf_id = vim.api.nvim_get_current_buf()
  end

  local file_buf_ids = M.get_file_buf_ids()

  if #file_buf_ids <= 1 then
    M.save_before_close(buf_id)
  else
    local buf_index = require("util").index_of(file_buf_ids, buf_id)

    local before_close_fn
    if buf_index == -1 then
      before_close_fn = function() end
    else
      local former_id
      if buf_index == 1 then
        former_id = file_buf_ids[#file_buf_ids]
      else
        former_id = file_buf_ids[buf_index - 1]
      end
      before_close_fn = function() vim.api.nvim_set_current_buf(former_id) end
    end

    M.save_before_close(buf_id, before_close_fn)
  end
end

return M
