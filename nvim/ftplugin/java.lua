-- See `:help vim.lsp.start` for an overview of the supported `config` options.
local config = {
  name = "jdtls",


  -- `cmd` defines the executable to launch eclipse.jdt.ls.
  -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
  --
  -- As alternative you could also avoid the `jdtls` wrapper and launch
  -- eclipse.jdt.ls via the `java` executable
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {"jdtls"},


  -- `root_dir` must point to the root of your project.
  -- See `:help vim.fs.root`
  root_dir = vim.fs.root(0, {'gradlew', '.git', 'mvnw'}),


  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },


  -- This sets the `initializationOptions` sent to the language server
  -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
  -- you'll need to set the `bundles`
  --
  -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
  vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
}


-- This is the new part
local java_test_bundles = vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar"), "\n")
local excluded = {
  "com.microsoft.java.test.runner-jar-with-dependencies.jar",
  "jacocoagent.jar",
}
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ":t")
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end
-- End of the new part


config['init_options'] = {
  bundles = bundles
}


require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>jo', require('jdtls').organize_imports, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jgt', require('jdtls.tests').generate, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jtn', require'jdtls'.test_nearest_method, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jtc', require('jdtls').test_class, { noremap = true, silent = true })
