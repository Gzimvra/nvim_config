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
  vim.diagnostic.config {
    signs = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  ------------------------------------------------
  -- Server configurations
  ------------------------------------------------
  
  -- Lua LSP
  vim.lsp.config("lua_ls", {
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

  -- Clangd
  vim.lsp.config("clangd", {
    capabilities = M.capabilities,
    on_init = M.on_init,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  })

  -- JSON
  vim.lsp.config("jsonls", {
    capabilities = M.capabilities,
    on_init = M.on_init,
    settings = {
      json = {
        validate = { enable = true },
      },
    },
  })

  -- YAML
  vim.lsp.config("yamlls", {
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

  -- HTML
  vim.lsp.config("html", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  -- CSS
  vim.lsp.config("cssls", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  -- Python
  vim.lsp.config("pyright", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  -- Go
  vim.lsp.config("gopls", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  -- TypeScript
  vim.lsp.config("ts_ls", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  -- Rust
  vim.lsp.config("rust_analyzer", {
    capabilities = M.capabilities,
    on_init = M.on_init,
  })

  ------------------------------------------------
  -- Enable servers based on filetype
  ------------------------------------------------
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype

      -- Map filetypes to LSP servers
      local ft_to_server = {
        lua = "lua_ls",
        c = "clangd",
        cpp = "clangd",
        objc = "clangd",
        objcpp = "clangd",
        cuda = "clangd",
        json = "jsonls",
        yaml = "yamlls",
        html = "html",
        css = "cssls",
        python = "pyright",
        go = "gopls",
        javascript = "ts_ls",
        typescript = "ts_ls",
        javascriptreact = "ts_ls",
        typescriptreact = "ts_ls",
        rust = "rust_analyzer",
      }

      local server = ft_to_server[ft]
      if server then
        vim.lsp.enable(server)
      end
    end,
  })
end

return M