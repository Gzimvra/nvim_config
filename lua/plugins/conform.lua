return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        -- html = { "prettier" },
      },

      -- Uncomment to enable format on save
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    })
  end,
}