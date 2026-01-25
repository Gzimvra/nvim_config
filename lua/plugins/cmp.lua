return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        -- CMP sources
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "https://codeberg.org/FelipeLema/cmp-async-path.git",
        "onsails/lspkind-nvim",

        -- Snippet engine
        {
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip").config.set_config({
                    history = true,
                    updateevents = "TextChanged,TextChangedI",
                })

                local luasnip = require("luasnip")

                -- Load vscode format snippets
                require("luasnip.loaders.from_vscode").lazy_load({
                    exclude = vim.g.vscode_snippets_exclude or {},
                })
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = vim.g.vscode_snippets_path or "",
                })

                -- Load snipmate format snippets
                require("luasnip.loaders.from_snipmate").load()
                require("luasnip.loaders.from_snipmate").lazy_load({
                    paths = vim.g.snipmate_snippets_path or "",
                })

                -- Load lua format snippets
                require("luasnip.loaders.from_lua").load()
                require("luasnip.loaders.from_lua").lazy_load({
                    paths = vim.g.lua_snippets_path or "",
                })

                -- Fix LuaSnip issue #258: prevent stuck snippet nodes
                vim.api.nvim_create_autocmd("InsertLeave", {
                    callback = function()
                        local buf = vim.api.nvim_get_current_buf()
                        if luasnip.session.current_nodes[buf] and not luasnip.session.jump_active then
                            luasnip.unlink_current()
                        end
                    end,
                })
            end,
        },

        -- Autopairs
        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = true, -- enables treesitter integration
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                })

                -- Setup cmp for autopairs
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        cmp.setup({
            completion = {
                completeopt = "menu,menuone",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
                },
                documentation = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
                },
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text", -- shows icon + text
                    maxwidth = 50,        -- truncate long suggestions
                    ellipsis_char = "...",
                    preset = "default",
                    menu = {
                        buffer = "[buf]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[snip]",
                        path = "[path]",
                        async_path = "[path]",
                        nvim_lua = "[api]",
                    },
                }),
            },
            experimental = {
                ghost_text = false, -- shows preview of completion inline
                native_menu = false,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<Esc>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }),
                ["<Tab>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "nvim_lua" },
                { name = "async_path" },
            },
        })

        -- SQL-specific completion
        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })

        -- Cmdline completion
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path" },
                { name = "cmdline" },
            },
        })
    end,
}
