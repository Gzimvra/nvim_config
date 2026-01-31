return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    -- cmd = "Telescope",
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

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
                    n = {
                        ["q"] = actions.close,
                    },
                },

                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },

            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
                },
            },

            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Load extensions
        telescope.load_extension("ui-select")
        telescope.load_extension("fzf")
    end,
}

