-- Core editor modules
require("core.options")
require("core.autocmds")
vim.schedule(function()
  require("core.mappings")
end)

-- Lazy + plugins
require("config.lazy")
