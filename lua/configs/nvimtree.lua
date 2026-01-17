dofile(vim.g.base46_cache .. "nvimtree")

return {
  filters = { dotfiles = false },
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 25,
    adaptive_size = true,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        -- git = { unmerged = "" },
      },
    },
  },
}
