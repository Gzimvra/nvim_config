return {
    {
        "folke/trouble.nvim",
        opts = {
            -- Global settings (apply to all modes unless overridden)
            padding = true,
            indent_guides = true,

            modes = {
                -- Diagnostics: Bottom split with height of 15
                diagnostics = {
                    focus = true, -- Autofocus when opened
                    win = {
                        position = "bottom",
                        size = 15, -- Size refers to height when position is bottom
                    },
                },

                -- Symbols: Right split with width of 40
                symbols = {
                    focus = true, -- Autofocus when opened
                    win = {
                        position = "right",
                        size = 50, -- Size refers to width when position is right
                    },
                },
            },
        },
    },
}

