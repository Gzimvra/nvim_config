return {
    -- Gitsigns - Git decorations and hunks
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signcolumn = true,
                numhl = false,
                linehl = false,

                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },

                current_line_blame = false,

                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                    map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle blame")
                    map("n", "<leader>gs", gs.toggle_signs, "Toggle git signs")
                end,
            })
        end,
    },

    -- Fugitive - Git commands
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
        -- Uncomment to add keybindings
        -- keys = {
        --   { "<leader>gf", "<cmd>Git<CR>", desc = "Git status" },
        -- },
    },

    -- Diffview - Git diff viewer
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
        config = function()
            require("diffview").setup({
                use_icons = false,
            })
        end,
        -- Uncomment to add keybindings
        -- keys = {
        --   { "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
        --   { "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
        -- },
    },
}
