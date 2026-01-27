return {
    "nvim-neotest/neotest",
    dependencies = {
        -- Dependencies
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Adapters
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
        "nvim-neotest/neotest-go",
    },
    event = "VeryLazy",
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                -- Python Adapter
                require("neotest-python")({
                    -- Extra arguments for nvim-dap configuration
                    -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                    dap = { justMyCode = false },
                    -- Command line arguments for runner
                    -- Can also be a function to return dynamic values
                    args = { "-v", "--maxfail=1", "--log-level", "DEBUG" },
                    -- Runner to use. Will use pytest if available by default.
                    -- Can be a function to return dynamic value.
                    runner = "pytest",
                    -- Custom python path for the runner.
                    -- Can be a string or a list of strings.
                    -- Can also be a function to return dynamic value.
                    -- If not provided, the path will be inferred by checking for
                    -- virtual envs in the local directory and for Pipenev/Poetry configs
                    python = ".venv/bin/python",
                    env = { PYTHONPATH = vim.fn.getcwd() },
                }),

                -- Javascript/Typescript Adapter (Jest)
                require("neotest-jest")({
                    jestCommand = "npm test --",              -- command to run jest
                    jestArguments = function(defaultArguments, context)
                        return defaultArguments               -- you can customize per file if needed
                    end,
                    jestConfigFile = "custom.jest.config.ts", -- optional, remove if default
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd() -- always run from project root
                    end,
                    isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
                }),

                -- Golang Adapter
                require("neotest-go")({
                    -- Arguments to pass to `go test`
                    args = {
                        "-v",    -- verbose output for each test
                        "-race", -- the race detector watches all shared memory access in goroutines to catch data races, which can make the tests run slightly slower
                        "-cover" -- measures how much of the code is exercised by tests & reports the percentage of statements executed.
                    },
                    -- Environment variables for test runs
                    env = { GOFLAGS = "-count=1" }, -- disables caching so tests always rerun
                    -- You can also set per-test or per-package options here
                    -- Example: run tests with race detection
                    -- args = {"-v", "-race"},
                }),
            },

            discovery = { enabled = true, concurrent = 4, },
            running = { concurrent = true, },
            output = { enabled = true, open_on_run = "short", },
            summary = { enabled = true, follow = true, expand_errors = true, },
            status = { enabled = true, },
            diagnostic = { enabled = true, },
            quickfix = { enabled = false, }, -- enable if you like QF-based workflows
        })
    end,
}
