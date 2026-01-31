return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require "lint"

        -- Configure linters by filetype
        lint.linters_by_ft = {
            python = { "pylint" }, -- use flake8 or ruff if pylint gets too noisy
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            go = { "golangcilint" },
            -- markdown = { "markdownlint" },
            -- yaml = { "yamllint" },
            -- json = { "jsonlint" },
        }

        -- Create autocommand for linting
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = lint_augroup,
            callback = function()
                if vim.bo.buftype ~= "" then
                    return
                end
                lint.try_lint()
            end,
        })
    end,
}
