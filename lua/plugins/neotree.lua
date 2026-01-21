return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,

            default_component_configs = {
                indent = {
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    with_expanders = true,
                },
                icon = {
                    default = "󰈚",
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    folder_empty_open = "",
                },
                git_status = {
                    symbols = {
                        -- Change these to your liking
                        added     = "A",
                        modified  = "M",
                        deleted   = "D",
                        renamed   = "R",
                        untracked = "U",
                        ignored   = "I",
                        unstaged  = "U",
                        staged    = "S",
                        conflict  = "C",
                    },
                    align = "right",
                },
            },

            window = {
                position = "left",
                width = 30,
                auto_expand_width = true, -- expand the window when file exceeds the window width. does not work with position = "float"
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = "none", -- disable space if you want
                },
            },

            filesystem = {
                bind_to_cwd = false,
                filtered_items = {
                    visible = true, -- Show hidden items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false, -- This is important - shows system hidden files
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                use_libuv_file_watcher = true,
                hijack_netrw_behavior = "open_current",
                components = {
                    name = function(config, node, state)
                        local name = node.name
                        if node:get_depth() == 1 then
                            name = vim.fn.fnamemodify(node.path, ":t")
                        end
                        return {
                            text = name,
                            highlight = config.highlight or "NeoTreeFileName",
                        }
                    end,
                },
            },
        })
    end,
}
