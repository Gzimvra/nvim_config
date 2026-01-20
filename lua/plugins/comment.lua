return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                -- Disable all default mappings
                toggler = {
                    line = nil,
                    block = nil,
                },
                opleader = {
                    line = nil,
                    block = nil,
                },
                extra = {
                    above = nil,
                    below = nil,
                    eol = nil,
                },
            })
        end,
    },
}
