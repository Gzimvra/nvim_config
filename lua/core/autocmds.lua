local augroup = vim.api.nvim_create_augroup
local GeoZimGroup = augroup('GeoZim', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = GeoZimGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = GeoZimGroup,
    callback = function(e)
        local opts = { buffer = e.buf }

        -- Key mappings for LSP functions
        vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts, { desc = "[H]over Documentation" })
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts, { desc = "[C]ode [A]ctions" })
        vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts, { desc = "[G]o to [D]efinition" })
        vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts, { desc = "[G]o to [R]eferences" })
        vim.keymap.set("n", "<leader>gt", function() vim.lsp.buf.type_definition() end, opts, { desc = "[G]o to [T]ype Definition" })
        vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, opts, { desc = "[G]o to [I]mplementation" })
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts, { desc = "[R]ename all Instances" })
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts, { desc = "[F]ormat Current File" })
        vim.keymap.set("v", "<leader>f", function()
            local start_pos = vim.api.nvim_buf_get_mark(0, "<") -- start of visual selection
            local end_pos = vim.api.nvim_buf_get_mark(0, ">") -- end of visual selection
            vim.lsp.buf.format({
                range = {
                    start = { start_pos[1], start_pos[2] },
                    ["end"] = { end_pos[1], end_pos[2] },
                },
                async = true,
            })
        end, opts, { desc = "[F]ormat Selected Range" })
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts, { desc = "Find [W]orkplace [S]ymbol" })
        --vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts, { desc = Open [D]iagnostics Window}) -- Show error below cursor
        vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist() end, opts, { desc = "Open [D]iagnostic [L]ist" }) -- Show list of file errors
    end
})


-- local autocmd = vim.api.nvim_create_autocmd

-- -- user event that loads after UIEnter + only if file buf is there
-- autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
--   callback = function(args)
--     local file = vim.api.nvim_buf_get_name(args.buf)
--     local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

--     if not vim.g.ui_entered and args.event == "UIEnter" then
--       vim.g.ui_entered = true
--     end

--     if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
--       vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
--       vim.api.nvim_del_augroup_by_name "NvFilePost"

--       vim.schedule(function()
--         vim.api.nvim_exec_autocmds("FileType", {})

--         if vim.g.editorconfig then
--           require("editorconfig").config(args.buf)
--         end
--       end)
--     end
--   end,
-- })
