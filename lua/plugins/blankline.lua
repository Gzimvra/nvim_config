return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    config = function()
        local hooks = require("ibl.hooks")

        -- Hide first space indent level
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

        require("ibl").setup({
            indent = {
                char = "│",
                highlight = "IblChar"
            },
            scope = {
                char = "│",
                highlight = "IblScopeChar"
            },
        })

        -- Load base46 blankline highlights again (ensures proper coloring)
        pcall(function()
            dofile(vim.g.base46_cache .. "blankline")
        end)
    end,
}
