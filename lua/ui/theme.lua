function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    -- Setup rose-pine

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    bold = false,
                    italic = false,
                    transparency = false,
                },
            })

            -- vim.cmd("colorscheme rose-pine")
            -- ColorMyPencils()
        end,
    },
    {
        "vague2k/vague.nvim",
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            require("vague").setup({
                transparent = false, -- don't set background

                style = {
                    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
                    boolean = "none",
                    number = "none",
                    float = "none",
                    error = "none",
                    comments = "none",
                    conditionals = "none",
                    functions = "none",
                    headings = "none",
                    operators = "none",
                    strings = "none",
                    variables = "none",

                    -- keywords
                    keywords = "none",
                    keyword_return = "none",
                    keywords_loop = "none",
                    keywords_label = "none",
                    keywords_exception = "none",

                    -- builtin
                    builtin_constants = "none",
                    builtin_functions = "none",
                    builtin_types = "none",
                    builtin_variables = "none",
                },

                -- plugin styles where applicable
                plugins = {
                    cmp = {
                        match = "none",
                        match_fuzzy = "none",
                    },
                    dashboard = {
                        footer = "none",
                    },
                    lsp = {
                        diagnostic_error = "none",
                        diagnostic_hint = "none",
                        diagnostic_info = "none",
                        diagnostic_warn = "none",
                    },
                    neotest = {
                        focused = "none",
                        adapter_name = "none",
                    },
                    telescope = {
                        match = "none",
                    },
                },

                colors = {},
            })

            -- Choose which colorscheme to use
            vim.cmd("colorscheme vague")
        end,
    },
}
