return {
    "laytan/cloak.nvim",
    config = function()
        require('cloak').setup({
            enabled = true,
            cloak_character = '*',
            -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
            highlight_group = 'Comment',
            try_all_patterns = true,
            cloak_telescope = true,
            cloak_on_leave = false,
            patterns = {
                {
                    -- Match any file starting with '.env'.
                    -- This can be a table to match multiple file patterns.
                    file_pattern = {
                        '.env*'
                    },
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    cloak_pattern = '=.+',
                    replace = nil,
                },
            },
        })
    end,
}
