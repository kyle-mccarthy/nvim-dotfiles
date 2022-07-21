local tree = require('nvim-tree')

--[[ vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "",
    deleted = "",
    untracked = "",
    ignored = ""
  },
  folder = {
    arrow_closed = "",
    arrow_open = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = ""
  }
} ]]

tree.setup {
  actions = {open_file = {resize_window = true}},
  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          deleted = "",
          untracked = "",
          ignored = ""
        },
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = ""
        }
      }
    }
  }
}

vim.api.nvim_set_keymap(
  'n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true, nowait = true}
)
