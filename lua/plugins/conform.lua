return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black", "isort" },
				go = { "goimports", "gofmt" },
                java = { "google-java-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
			},
            formatters = {
                isort = {
                    args = { "--stdout", "--filename", "$FILENAME", "-" },
                },
                ["google-java-format"] = {
                    prepend_args = { "--aosp" },
                },
            },
			-- Uncomment to enable format on save
			-- format_on_save = {
			--   timeout_ms = 500,
			--   lsp_fallback = true,
			-- },
			-- format_after_save = {
			-- 	lsp_format = "fallback",
			-- },
			default_format_opts = { lsp_format = "fallback" },
			notify_on_error = true,
			notify_no_formatters = true,
		})
	end,
}
