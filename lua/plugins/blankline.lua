return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")

        -- Hide first indent level
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_space_indent_level
        )

        ibl.setup({
            indent = {
                char = "│",
                highlight = "IblIndent",
            },
            scope = {
                enabled = true,
                char = "│",
                highlight = "IblScope",
                show_start = false,
                show_end = false,
            },
            exclude = {
                buftypes = { "terminal", "nofile", "quickfix", "prompt" },
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                    "NvimTree",
                    "neo-tree",
                    "TelescopePrompt",
                },
            },
        })

        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#6f6f6f", bold = true })
    end,
}
