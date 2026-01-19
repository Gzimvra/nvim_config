return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "j-hui/fidget.nvim"
    },
    config = function()
        -- Store LSP progress messages
        local lsp_status = ""
        local lsp_client_name = ""
        local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        local spinner_index = 1
        local clear_timer = nil

        -- Update spinner every refresh
        vim.loop.new_timer():start(0, 100, vim.schedule_wrap(function()
            spinner_index = (spinner_index % #spinner_frames) + 1
        end))

        -- Hook into LSP progress
        local original_handler = vim.lsp.handlers['$/progress']
        vim.lsp.handlers['$/progress'] = function(err, result, ctx, config)
            if original_handler then
                original_handler(err, result, ctx, config)
            end

            local client = vim.lsp.get_client_by_id(ctx.client_id)
            if not client then return end

            local value = result.value
            if value.kind == 'end' then
                -- Delay clearing the message
                if clear_timer then
                    clear_timer:stop()
                    clear_timer:close()
                end
                clear_timer = vim.loop.new_timer()
                clear_timer:start(2000, 0, vim.schedule_wrap(function()
                    lsp_status = ""
                    lsp_client_name = ""
                    if clear_timer then
                        clear_timer:close()
                        clear_timer = nil
                    end
                end))
            elseif value.kind == 'begin' or value.kind == 'report' then
                -- Cancel any pending clear
                if clear_timer then
                    clear_timer:stop()
                    clear_timer:close()
                    clear_timer = nil
                end

                lsp_client_name = client.name
                local title = value.title or ""
                local msg = value.message or ""
                local percentage = value.percentage and string.format(" (%.0f%%%%)", value.percentage) or ""

                -- Combine title and message
                if title ~= "" and msg ~= "" then
                    lsp_status = string.format("%s %s%s", title, msg, percentage)
                else
                    lsp_status = string.format("%s%s", title ~= "" and title or msg, percentage)
                end
            end
        end

        -- Helper for Lualine_x: Show LSP name(s)
        local function lsp_name()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = bufnr }) -- modern way

            if #clients == 0 then return "LSP ~ None" end

            local names = {}
            for _, c in ipairs(clients) do
                table.insert(names, c.name)
            end
            return "LSP ~ " .. table.concat(names, ", ")
        end

        require('lualine').setup {
            options = {
                icons_enabled        = true,
                theme                = "gruvbox",
                component_separators = { left = '›', right = '‹' },
                section_separators   = { left = '', right = '' },
                disabled_filetypes   = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus         = {},
                always_divide_middle = true,
                always_show_tabline  = true,
                globalstatus         = false,
                refresh              = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    function()
                        local fname = vim.fn.expand('%:t')
                        if fname == '' then
                            return ' [No Name]'
                        end

                        local ext = vim.fn.expand('%:e')
                        local icon = require('nvim-web-devicons').get_icon(fname, ext, { default = true })

                        return string.format('%s %s', icon, fname)
                    end,
                },

                lualine_c = {
                    { 'branch', icon = '' },
                    {
                        'diff',
                        symbols = {
                            added    = ' ',
                            modified = ' ',
                            removed  = ' ',
                        },
                    },
                    {
                        function()
                            return '%='
                        end,
                    },
                    {
                        function()
                            if lsp_status ~= "" and lsp_client_name ~= "" then
                                return string.format("%s %s: %s", spinner_frames[spinner_index], lsp_client_name,
                                    lsp_status)
                            end
                            return lsp_status
                        end,
                        color = { gui = 'italic,bold' },
                        cond = function() return lsp_status ~= "" end,
                    }
                },
                lualine_x = {
                    { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ' } },
                    { 'encoding', fmt = string.upper },
                    { "filesize", colored = true },
                    {
                        function()
                            return " " .. lsp_name()
                        end,
                    },
                },
                lualine_y = {
                    function()
                        local progress = vim.fn.line('.') * 100 / vim.fn.line('$')
                        local location = vim.fn.line('.') .. ":" .. vim.fn.col('.')
                        return string.format(" %d%%%%  %s", progress, location)
                    end,
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                }
            },
            inactive_sections = {
                lualine_c = { { "filename", path = 0 } },
                lualine_x = { "location" },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end,
}
