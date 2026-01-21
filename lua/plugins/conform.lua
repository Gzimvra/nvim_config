return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- python = { "black", "isort" },
                -- go = { "gofmt", "goimports" },
                -- javascript = { "prettier" },
                -- typescript = { "prettier" },
                -- javascriptreact = { "prettier" },
                -- typescriptreact = { "prettier" },
                -- json = { "prettier" },
                -- yaml = { "prettier" },
                -- markdown = { "prettier" },
                -- html = { "prettier" },
                -- css = { "prettier" },
            },
            -- Uncomment to enable format on save
            -- format_on_save = {
            --   timeout_ms = 500,
            --   lsp_fallback = true,
            -- },
        })
    end,
}

