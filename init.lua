-- Core editor modules
require("core.options")
require("core.autocmds")
vim.schedule(function()
  require("core.mappings")
  require("core.plugin_mappings")
end)

-- Lazy + plugins
require("config.lazy")
