return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    event = "VeryLazy",
    config = function()
        -- Setup Neogen with LuaSnip as the snippet engine
        require("neogen").setup({
            snippet_engine = "luasnip",
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings",
                    },
                },
                -- Add other languages as needed
            },
        })
    end,

    -- Optional: Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
