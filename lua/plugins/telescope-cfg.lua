local map = vim.api.nvim_set_keymap
local options = {noremap = true, silent = false}

map('n', '<leader>t', '<cmd>lua require("telescope.builtin").find_files()<CR>', options)
map('n', '<leader>tg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', options)
map('n', '<leader>tb', '<cmd>lua require("telescope.builtin").buffers()<CR>', options)
map('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<CR>', options)

map('n', '<leader>ss', '<cmd>lua require("telescope.builtin").spell_suggest()<CR>', options)
map('n', '<leader>cmd', '<cmd>lua require("telescope.builtin").commands()<CR>', options)


map(
  'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions({jump_type = "never"})<CR>',
  options
)
map('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', options)

local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = {["<c-t>"] = trouble.open_with_trouble},
      n = {
        ["<c-t>"] = trouble.open_with_trouble
      }
    }
  },
  pickers = {
    lsp_definitions = {
      layout_strategy = "cursor",
      layout_config = {width = 0.5, height = 0.4}
    }
  },
}

