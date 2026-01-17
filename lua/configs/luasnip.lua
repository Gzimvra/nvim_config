local ok, luasnip = pcall(require, "luasnip")
if not ok then
  return
end

-- vscode format snippets
require("luasnip.loaders.from_vscode").lazy_load {
  exclude = vim.g.vscode_snippets_exclude or {},
}

require("luasnip.loaders.from_vscode").lazy_load {
  paths = vim.g.vscode_snippets_path or "",
}

-- snipmate format snippets
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load {
  paths = vim.g.snipmate_snippets_path or "",
}

-- lua format snippets
require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load {
  paths = vim.g.lua_snippets_path or "",
}

-- Fix LuaSnip issue #258: prevent stuck snippet nodes
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if luasnip.session.current_nodes[buf] and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})
