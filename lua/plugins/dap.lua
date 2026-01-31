return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- UI plugins for better debugging experience
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",

        -- Language-specific adapters
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        -- ============================================
        -- DAP UI Setup
        -- ============================================
        dapui.setup {
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    size = 10,
                    position = "bottom",
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
        }

        -- ============================================
        -- Virtual Text Setup
        -- ============================================
        require("nvim-dap-virtual-text").setup {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            filter_references_pattern = "<module>",
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        }

        -- ============================================
        -- Auto-open/close UI
        -- ============================================
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- ============================================
        -- Signs/Icons
        -- ============================================
        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define(
            "DapBreakpointCondition",
            { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
        )
        vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
        vim.fn.sign_define(
            "DapBreakpointRejected",
            { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
        )
        --
        --     -- ============================================
        --     -- Python Configuration
        --     -- ============================================
        --     require("dap-python").setup "python" -- or specify path to python with debugpy installed
        --     -- Example: require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        --
        --     table.insert(dap.configurations.python, {
        --         type = "python",
        --         request = "launch",
        --         name = "Launch file with arguments",
        --         program = "${file}",
        --         args = function()
        --             local args_string = vim.fn.input "Arguments: "
        --             return vim.split(args_string, " +")
        --         end,
        --     })
        --
        -- ============================================
        -- Go Configuration
        -- ============================================
        require("dap-go").setup {
            dap_configurations = {
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                args = {},
                build_flags = "",
            },
        }
        --
        --     -- ============================================
        --     -- JavaScript/TypeScript Configuration (using node-debug2)
        --     -- ============================================
        --     dap.adapters.node2 = {
        --         type = "executable",
        --         command = "node",
        --         args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
        --     }
        --
        --     dap.configurations.javascript = {
        --         {
        --             name = "Launch",
        --             type = "node2",
        --             request = "launch",
        --             program = "${file}",
        --             cwd = vim.fn.getcwd(),
        --             sourceMaps = true,
        --             protocol = "inspector",
        --             console = "integratedTerminal",
        --         },
        --         {
        --             name = "Attach to process",
        --             type = "node2",
        --             request = "attach",
        --             processId = require("dap.utils").pick_process,
        --         },
        --     }
        --
        --     dap.configurations.typescript = dap.configurations.javascript
        --
        --     -- ============================================
        --     -- C/C++/Rust Configuration (using lldb or gdb)
        --     -- ============================================
        --     -- Using lldb (macOS/Linux)
        --     dap.adapters.lldb = {
        --         type = "executable",
        --         command = "/usr/bin/lldb-vscode", -- adjust path as needed
        --         name = "lldb",
        --     }
        --
        --     -- Using gdb (Linux)
        --     dap.adapters.gdb = {
        --         type = "executable",
        --         command = "gdb",
        --         args = { "-i", "dap" },
        --     }
        --
        --     dap.configurations.cpp = {
        --         {
        --             name = "Launch",
        --             type = "lldb", -- or "gdb"
        --             request = "launch",
        --             program = function()
        --                 return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        --             end,
        --             cwd = "${workspaceFolder}",
        --             stopOnEntry = false,
        --             args = {},
        --             runInTerminal = false,
        --         },
        --         {
        --             name = "Attach to process",
        --             type = "lldb",
        --             request = "attach",
        --             pid = require("dap.utils").pick_process,
        --             args = {},
        --         },
        --     }
        --
        --     dap.configurations.c = dap.configurations.cpp
        --     dap.configurations.rust = dap.configurations.cpp
    end,
}
