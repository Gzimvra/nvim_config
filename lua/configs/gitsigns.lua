dofile(vim.g.base46_cache .. "git")

return {
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
  },

  current_line_blame = false,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle blame")
    map("n", "<leader>gs", gs.toggle_signs, "Toggle git signs")
  end,
}
