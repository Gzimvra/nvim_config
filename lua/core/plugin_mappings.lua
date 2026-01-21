local map = vim.keymap.set

-- ======================
-- NeoTree
-- ======================
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "neotree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus<CR>", { desc = "neotree focus window" })

-- ======================
-- Telescope
-- ======================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>")            -- Get the word under the cursor.
    vim.cmd("Telescope grep_string search=" .. word) -- Grep (search) that word in files using Telescope.
end, { desc = "search the current word under cursor (single word)" })
map('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")            -- Get the WORD (more comprehensive) under the cursor.
    vim.cmd("Telescope grep_string search=" .. word) -- Grep (search) that WORD in files using Telescope.
end, { desc = "search the current word under cursor (entire token)" })
-- map(
--   "n",
--   "<leader>fa",
--   "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
--   { desc = "telescope find all files" }
-- )

-- ======================
-- Comments
-- ======================
-- <C-_> is {Ctrl+/} because <C-/> is not recognized
map('n', '<C-_>', function()
    require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment on current line' })

map('x', '<C-_>', function()
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    local mode = vim.fn.visualmode()
    if mode == '\22' then -- \22 is Ctrl-V (visual block mode)
        require('Comment.api').toggle.blockwise(mode)
    else
        require('Comment.api').toggle.linewise(mode)
    end
end, { desc = 'Toggle comment on selection' })

-- ======================
-- Lsp
-- ======================

-- ======================
-- Git Stuff
-- ======================

-- ======================
-- Cmp
-- ======================
-- NOTE:
-- nvim-cmp mappings (cmp.mapping.*) are NOT normal Neovim keymaps.
-- They ONLY work while the completion menu is visible and MUST stay
-- inside cmp.setup({ mapping = { ... } }).
--
-- Do NOT move cmp mappings from plugins/cmp.lua to core/plugin_mappings.lua or vim.keymap.set
-- or anywhere else, they will NOT work.

-- ======================
-- Undotree
-- ======================
vim.keymap.set("n", "<leader>ut", function() vim.cmd.UndotreeToggle() end, { desc = "Toggle UndoTree" })

-- ======================
-- Trouble
-- ======================
map("n", "<leader>tt", function() require("trouble").toggle("diagnostics") end)
map("n", "<leader>ts", function() require("trouble").toggle("symbols") end, { desc = "Trouble symbols" })

-- ======================
-- Harpoon
-- ======================
map("n", "<leader>ha", function() require("harpoon"):list():add() end, { desc = "harpoon add file" })
map("n", "<leader>hm", function()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "harpoon toggle menu" })
map("n", "<C-a>", function() require("harpoon"):list():select(1) end, { desc = "harpoon file 1" })
map("n", "<C-s>", function() require("harpoon"):list():select(2) end, { desc = "harpoon file 2" })
map("n", "<C-d>", function() require("harpoon"):list():select(3) end, { desc = "harpoon file 3" })
map("n", "<C-f>", function() require("harpoon"):list():select(4) end, { desc = "harpoon file 4" })

-- ======================
-- Neotest
-- ======================

-- ======================
-- Neogen
-- ======================

-- ======================
-- Conform
-- ======================
-- map({ "n", "x" }, "<leader>fm", function()
--   require("conform").format { lsp_fallback = true }
-- end, { desc = "general format file" })
