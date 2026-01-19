return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        entry_prefix = "  ",
        multi_icon = "󰄬 ",
        -- path_display = { "smart" },
        sorting_strategy = "ascending",
        preview_cutoff = 500,
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },

      extensions_list = { "themes", "terms" },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- Load extensions
    telescope.load_extension("ui-select")
  end,
}
