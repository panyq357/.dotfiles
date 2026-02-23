M = {}

M.index_of = function(tb, q)
  for i, v in ipairs(tb) do
    if v == q then
      return i
    end
  end
  return -1
end

M.key_of = function(tb, q)
  for k, v in pairs(tb) do
    if v == q then
      return k
    end
  end
  return nil
end

return M
