return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            keymaps = {
                insert = false,                  -- Disable surround in insert mode
                insert_line = false,             -- Disable linewise surround in insert mode

                normal = "<leader>sa",           -- Add surround using a motion: <leader>sa{motion}{char} e.g. <leader>sa iw "
                normal_cur = "<leader>saa",      -- Add surround without a motion NOTE: Acts on the current line, NOT just the word
                normal_line = "<leader>sA",      -- Add a linewise (block) surround using a motion e.g. <leader>sA ap {
                normal_cur_line = "<leader>sAA", -- Add a linewise surround to the current line

                visual = "<leader>sa",           -- Add surround to visual selection (characterwise) e.g. visually select → <leader>sa "
                visual_line = "<leader>sA",      -- Add surround to visual selection, linewise e.g. V select lines → <leader>sA {

                delete = "<leader>sd",           -- Delete the surrounding pair under the cursor e.g. <leader>sd "
                change = "<leader>sc",           -- Change one surround to another e.g. <leader>sc"'
            },
        })
    end
}
