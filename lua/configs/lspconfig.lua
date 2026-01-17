local M = {}
local map = vim.keymap.set

--------------------------------------------------
-- on_attach
--------------------------------------------------
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map("n", "<leader>ra", vim.lsp.buf.rename, opts "Rename symbol")
end

--------------------------------------------------
-- on_init: disable semantic tokens
--------------------------------------------------
M.on_init = function(client, _)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

--------------------------------------------------
-- capabilities (merged + cmp-friendly)
--------------------------------------------------
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

M.capabilities = capabilities

--------------------------------------------------
-- defaults
--------------------------------------------------
M.defaults = function()
  -- Base46 LSP highlights
  if vim.uv.fs_stat(vim.g.base46_cache .. "lsp") then
    dofile(vim.g.base46_cache .. "lsp")
  end

  -- Attach on LspAttach
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(nil, args.buf)
    end,
  })

  ------------------------------------------------
  -- Diagnostics UI
  ------------------------------------------------
  vim.diagnostic.config({
    update_in_insert = true,
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

  -- Set highlight for the virtual text itself (not the line)
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#eb6f92", bg = "#2a1418" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#f6c177", bg = "#2f2114" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#9ccfd8", bg = "#1a2633" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#c4a7e7", bg = "#231d33" })

  ------------------------------------------------
  -- Mason LSPConfig Setup
  ------------------------------------------------
  require("mason").setup()
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
    -- automatic_installation = true,

    ------------------------------------------------
    -- Handlers for automatic server setup
    ------------------------------------------------
    handlers = {
      -- Default handler for all servers
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- Lua LSP
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "after_each" },
              },
              workspace = {
                library = {
                  vim.fn.expand "$VIMRUNTIME/lua",
                  vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua",
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
          capabilities = M.capabilities,
          on_init = M.on_init,
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
          capabilities = M.capabilities,
          on_init = M.on_init,
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
          capabilities = M.capabilities,
          on_init = M.on_init,
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
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- CSS
      ["cssls"] = function()
        require("lspconfig").cssls.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- Python
      ["pyright"] = function()
        require("lspconfig").pyright.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- Go
      ["gopls"] = function()
        require("lspconfig").gopls.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- TypeScript
      ["ts_ls"] = function()
        require("lspconfig").ts_ls.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- Rust
      ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,

      -- Docker
      ["dockerls"] = function()
        require("lspconfig").dockerls.setup({
          capabilities = M.capabilities,
          on_init = M.on_init,
        })
      end,
    }
  })
end

return M
