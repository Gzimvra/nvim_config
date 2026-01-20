local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------

-- UI
o.laststatus = 3           -- Global statusline
o.showmode = false         -- Hide -- INSERT --
o.splitkeep = "screen"     -- Prevent cursor jump on split

-- Clipboard
o.clipboard = "unnamedplus" -- Use system clipboard

-- Cursor
o.cursorline = true
o.cursorlineopt = "number" -- Highlight only line number

-- ======================
-- Indentation
-- ======================
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true

-- ======================
-- Searching
-- ======================
o.ignorecase = true        -- Case-insensitive search
o.smartcase = true         -- Case-sensitive if uppercase used
opt.hlsearch = false       -- Do not highlight all matches
opt.incsearch = true      -- Show matches while typing

-- ======================
-- Mouse
-- ======================
o.mouse = "a"

-- ======================
-- Wrapping
-- ======================
opt.wrap = false           -- Disable line wrapping
opt.linebreak = true      -- Wrap only at word boundaries
opt.breakindent = true    -- Preserve indent on wrapped lines

-- ======================
-- Line numbers
-- ======================
opt.nu = true
opt.relativenumber = true
o.numberwidth = 2
o.ruler = false

-- ======================
-- Splits
-- ======================
o.splitbelow = true
o.splitright = true

-- ======================
-- Files / Undo
-- ======================
opt.swapfile = false      -- Disable swap files
opt.backup = false        -- Disable backup files
o.undofile = true         -- Persistent undo

-- ======================
-- Timing / Performance
-- ======================
o.timeoutlen = 400        -- Faster key sequence timeout
opt.updatetime = 50       -- Faster diagnostics & git updates

-- ======================
-- Scrolling / Signs
-- ======================
opt.scrolloff = 10        -- Keep context above/below cursor
opt.signcolumn = "yes"    -- Always show sign column

-- ======================
-- Filename handling
-- ======================
opt.isfname:append "@-@"  -- Allow @ in filenames

-- ======================
-- Navigation
-- ======================
-- Allow cursor to move across lines with h/l
opt.whichwrap:append "<>[]hl"

-- ======================
-- Colors
-- ======================
opt.termguicolors = true  -- Enable true color support

-- ======================
-- Disable unused providers
-- ======================
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- ======================
-- Leader key
-- ======================
g.mapleader = " "

-- ======================
-- netrw (file explorer) behavior
-- ======================
g.netrw_browse_split = 0  -- Open files in same window
g.netrw_banner = 0        -- Hide netrw banner
g.netrw_winsize = 25      -- netrw window size

-- ======================
-- Mason PATH integration
-- ======================
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"

-- Add Mason-installed binaries to PATH
vim.env.PATH =
  table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep)
  .. delim
  .. vim.env.PATH
