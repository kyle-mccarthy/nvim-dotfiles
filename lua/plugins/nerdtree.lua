vim.api.nvim_set_keymap(
  'n', '<leader>n', ':NERDTreeFocus<CR>', {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n', '<C-n>', ':NERDTree<CR>', {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n', '<C-t>', ':NERDTreeToggle<CR>', {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n', '<C-f>', ':NERDTreeFind<CR>', {noremap = true, silent = true}
)

vim.api.nvim_set_var('NERDTreeIgnore', {'^__pycache__$'})

