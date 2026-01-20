local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Ex command-line mode" })

map("n", "<A-z>", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap is now " .. (vim.wo.wrap and "ON" or "OFF"))
end, { desc = "Toggle line wrap with Alt+z" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves the selected lines down one line" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves the selected lines up one line" })

map("x", "<leader>p", [["_dP]], { desc = "Delete without copying in visual mode" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copying in normal and visual modes" })
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
map("n", "gg", "ggzz", { desc = "Go to top of file and center cursor" })
map("n", "G", "Gzz", { desc = "Go to bottom of file and center cursor" })
map("n", "<M-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
map("n", "<M-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
map("n", "n", "nzzzv", { desc = "Go to next search result and highlight" })
map("n", "N", "Nzzzv", { desc = "Go to previous search result and highlight" })

map("n", "Q", "<Nop>", { desc = "Disable Q" })
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Substitute word under cursor throughout file (whole word, case-insensitive)"
})
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
  silent = true,
  desc = "Make current file executable"
})

-- LANGUAGE SPECIFIC KEYBINDING
-- GOLANG:
map("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", {
  desc = "Insert Go error check: if err != nil { return err }"
})
map("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a", {
  desc = "Insert Go assert.NoError()"
})
map("n", "<leader>ef", "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj", {
  desc = "Insert Go logging Fatal Errors"
})
map("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i", {
  desc = "Insert Go logger.Error"
})












-- map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
-- map("i", "<C-e>", "<End>", { desc = "move end of line" })
-- map("i", "<C-h>", "<Left>", { desc = "move left" })
-- map("i", "<C-l>", "<Right>", { desc = "move right" })
-- map("i", "<C-j>", "<Down>", { desc = "move down" })
-- map("i", "<C-k>", "<Up>", { desc = "move up" })

-- map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
-- map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
-- map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- -- global lsp mappings / can be used instead of trouble plugin
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- terminal
-- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
