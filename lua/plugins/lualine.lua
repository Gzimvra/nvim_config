return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "j-hui/fidget.nvim" },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    "encoding",
                    "filetype",
                    { "filesize", colored = true }, -- live filesize
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
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
