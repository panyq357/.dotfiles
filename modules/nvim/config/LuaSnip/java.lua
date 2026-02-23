local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node


local function package_line(args, snip)
  local path = vim.fn.expand("%:p:h")

  if string.find(path, "src/main/java") == nil then
    return {""}
  else
    return {"package " .. path:gsub(".*src/main/java/", ""):gsub("/", ".") .. ";", ""}
  end
end

local function filename(args, snip)
  return vim.fn.expand("%:t:r")
end

return {

  s("class", {
    f(package_line, {}),
    i(1), t({"", ""}),
    t("public class "), f(filename, {}), t(" "), i(2), t({"{", ""}),
    t("\t"), i(0), t({"", ""}),
    t("}")
  }),

  s("interface", {
    f(package_line, {}),
    i(1), t({"", ""}),
    t("public interface "), f(filename, {}), t(" "), i(2), t({"{", ""}),
    t("\t"), i(0), t({"", ""}),
    t("}")
  }),

  s("psvm", {
    t({"public static void main(String[] args) {", "\t"}),
    i(0),
    t({"", "}"})
  }),

}
