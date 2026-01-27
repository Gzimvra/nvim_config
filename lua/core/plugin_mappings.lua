local map = vim.keymap.set

-- ======================
-- NeoTree
-- ======================
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "neotree toggle window" })
map("n", "<leader>e", "<cmd>Neotree focus<CR>", { desc = "neotree focus window" })

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
-- map( "n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })

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
-- Navigation
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP: [G]o to [D]efinition" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP: [G]o to [R]eferences" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP: [G]o to [I]mplementation" })
map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "LSP: [G]o to [T]ype Definition" })

-- Actions
map("n", "<leader>h", vim.lsp.buf.hover, { desc = "LSP: [H]over Documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ctions" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]ename all Instances" })

-- Formatting
map("n", "<A-F>", vim.lsp.buf.format, { desc = "LSP: [F]ormat Current File" })
map("v", "<A-F>", function()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    vim.lsp.buf.format({
        range = {
            start = { start_pos[1], start_pos[2] },
            ["end"] = { end_pos[1], end_pos[2] },
        },
        async = true,
    })
end, { desc = "LSP: [F]ormat Selected Range" })

-- Workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP: Remove workspace folder" })
map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "LSP: List workspace folders" })
map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "LSP: Find [W]orkplace [S]ymbol" })

-- Diagnostics
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "LSP: Open [D]iagnostic [L]ist" })

-- ======================
-- Undotree
-- ======================
map("n", "<leader>ut", function() vim.cmd.UndotreeToggle() end, { desc = "Toggle UndoTree" })

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
local neotest = require("neotest")

-- Run tests
map("n", "<leader>tn", function() neotest.run.run() end, { desc = "Run nearest test" })
map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run tests in current file" })
map("n", "<leader>ta", function() neotest.run.run(vim.loop.cwd()) end, { desc = "Run all tests" })
map("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "Run last test" })

-- Output
map("n", "<leader>tc", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Open test output" })
map("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle output panel" })

-- Stop
map("n", "<leader>tq", function() neotest.run.stop() end, { desc = "Stop running tests" })

-- ======================
-- Neogen
-- ======================
local neogen = require("neogen")

-- Auto-detect context (function, class, type, etc.)
map("n", "<leader>ng", function() neogen.generate() end, { desc = "Generate annotation (auto)" })

-- Specific generators
map("n", "<leader>nf", function() neogen.generate({ type = "func" }) end, { desc = "Generate function docstring" })
map("n", "<leader>nt", function() neogen.generate({ type = "type" }) end, { desc = "Generate type docstring" })
map("n", "<leader>nc", function() neogen.generate({ type = "class" }) end, { desc = "Generate class docstring" })

-- ======================
-- Surround
-- ======================
-- NOTE:
-- nvim-surround v3+ does NOT provide (probably, can't find it) a Lua API like add(), delete(), or change().
-- This means we cannot move the keymaps here as Lua functions.
-- They are kept in lua/plugins/surround.lua where the plugin is configured.

-- ======================
-- Git Stuff
-- ======================
-- NOTE:
-- The Git keymaps cannot be moved directly into this file because
-- they plugins are buffer-local and only attach to git-tracked buffers.
-- The keymaps rely on the `on_attach(bufnr)` hook to get the correct buffer context
-- and access the gitsigns API safely.
-- Therefore, the actual keymaps are defined in: lua/plugins/git-stuff.lua

-- ======================
-- Cmp
-- ======================
-- NOTE:
-- nvim-cmp mappings (cmp.mapping.*) are NOT normal Neovim keymaps.
-- They ONLY work while the completion menu is visible and MUST stay
-- inside cmp.setup({ mapping = { ... } }).
--
-- Do NOT move cmp mappings from lua/plugins/cmp.lua to core/plugin_mappings.lua or vim.keymap.set
-- or anywhere else, they will NOT work.

-- ======================
-- Conform
-- ======================
-- map({ "n", "x" }, "<leader>fm", function()
--   require("conform").format { lsp_fallback = true }
-- end, { desc = "general format file" })
