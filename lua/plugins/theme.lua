function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Diagnostic highlights
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#eb6f92", bg = "#2a1418" })
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#f6c177", bg = "#2f2114" })
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#9ccfd8", bg = "#1a2633" })
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#c4a7e7", bg = "#231d33" })

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
    -- Setup vague2k
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

            -- vim.cmd("colorscheme vague")
        end,
    },
    -- Setup vesper
    {
        "datsfilipe/vesper.nvim",
        name = "vesper",
        config = function()
            require('vesper').setup({
                transparent = false,   -- Boolean: Sets the background to transparent
                italics = {
                    comments = false,  -- Boolean: Italicizes comments
                    keywords = false,  -- Boolean: Italicizes keywords
                    functions = false, -- Boolean: Italicizes functions
                    strings = false,   -- Boolean: Italicizes strings
                    variables = false, -- Boolean: Italicizes variables
                },
                overrides = {},        -- A dictionary of group names, can be a function returning a dictionary or a table.
                palette_overrides = {}
            })

            -- vim.cmd("colorscheme vesper")
        end

        --
    },
    -- Setup mellifluous
    {
        "ramojus/mellifluous.nvim",
        name = "mellifluous",
        -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
        config = function()
            require("mellifluous").setup({

            }) -- optional, see configuration section.

            -- vim.cmd("colorscheme mellifluous")
        end,
    },
    -- Setup kanagawa
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            -- Default options:
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { bold = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = false },
                typeStyle = {},
                transparent = false,   -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {             -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    local makeDiagnosticColor = function(color)
                        local c = require("kanagawa.lib.color")
                        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                    end

                    return {
                        -- To make the Telescope UI blocky
                        --[[
                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                        ]]

                        -- Traditional vim highlight groups
                        Boolean                    = { bold = false },
                        Constant                   = { bold = false },
                        Identifier                 = { bold = false },
                        Function                   = { bold = false },
                        Statement                  = { bold = false },
                        PreProc                    = { bold = false },
                        Type                       = { bold = false },
                        Special                    = { bold = false },
                        Keyword                    = { bold = false },

                        DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
                        DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
                        DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
                        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
                    }
                end,
                theme = "dragon",    -- Load "wave" theme
                background = {       -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                },
            })

            vim.cmd("colorscheme kanagawa-dragon")
        end
    }
}
