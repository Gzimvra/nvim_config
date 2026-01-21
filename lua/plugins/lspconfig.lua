return {
    -- Mason - LSP/DAP/Linter installer
    {
        "mason-org/mason.nvim",
        -- cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        lazy = false,
        config = function()
            require("mason").setup({
                PATH = "skip",
                ui = {
                    border = "rounded",
                    icons = {
                        package_pending = " ",
                        package_installed = " ",
                        package_uninstalled = " ",
                    },
                },
                max_concurrent_installers = 10,
            })
        end,
    },

    -- Mason LSPConfig - Bridge between mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "mason.nvim" },
    },

    -- LSPConfig - Neovim LSP configuration
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            }

            local on_init = function(client, _)
                if client:supports_method("textDocument/semanticTokens") then
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end

            local on_attach = function(_, bufnr)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP " .. desc })
                end

                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "List workspace folders")
                map("n", "<leader>ra", vim.lsp.buf.rename, "Rename symbol")
            end

            -- Attach keymaps on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    on_attach(nil, args.buf)
                end,
            })

            -- Diagnostics UI
            vim.diagnostic.config({
                update_in_insert = false,
                underline = false,
                severity_sort = true,
                virtual_text = {
                    spacing = 4,
                    prefix = "■",
                    format = function(diagnostic)
                        return diagnostic.message
                    end,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = "",
                    },
                },
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Mason-lspconfig setup
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "jsonls",
                    "yamlls",
                    "html",
                    "cssls",
                    "pyright",
                    "gopls",
                    "ts_ls",
                    "rust_analyzer",
                    "dockerls",
                },
                handlers = {
                    -- Default handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- Lua LSP
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                            settings = {
                                Lua = {
                                    runtime = { version = "LuaJIT" },
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    },
                                    workspace = {
                                        library = {
                                            vim.fn.expand("$VIMRUNTIME/lua"),
                                            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua",
                                            "${3rd}/luv/library",
                                        },
                                    },
                                    format = {
                                        enable = true,
                                        defaultConfig = {
                                            indent_style = "space",
                                            indent_size = "4",
                                        },
                                    },
                                },
                            },
                        })
                    end,

                    -- Clangd
                    ["clangd"] = function()
                        require("lspconfig").clangd.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                            cmd = { "clangd" },
                            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                            root_dir = require("lspconfig.util").root_pattern(
                                "compile_commands.json",
                                "compile_flags.txt",
                                ".git"
                            ),
                        })
                    end,

                    -- JSON
                    ["jsonls"] = function()
                        require("lspconfig").jsonls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                            settings = {
                                json = {
                                    validate = { enable = true },
                                },
                            },
                        })
                    end,

                    -- YAML
                    ["yamlls"] = function()
                        require("lspconfig").yamlls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                            settings = {
                                yaml = {
                                    validate = true,
                                    schemas = {
                                        kubernetes = "*.yaml",
                                    },
                                },
                            },
                        })
                    end,

                    -- HTML
                    ["html"] = function()
                        require("lspconfig").html.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- CSS
                    ["cssls"] = function()
                        require("lspconfig").cssls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- Python
                    ["pyright"] = function()
                        require("lspconfig").pyright.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- Go
                    ["gopls"] = function()
                        require("lspconfig").gopls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- TypeScript
                    ["ts_ls"] = function()
                        require("lspconfig").ts_ls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- Rust
                    ["rust_analyzer"] = function()
                        require("lspconfig").rust_analyzer.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,

                    -- Docker
                    ["dockerls"] = function()
                        require("lspconfig").dockerls.setup({
                            capabilities = capabilities,
                            on_init = on_init,
                        })
                    end,
                },
            })
        end,
    },
}
