vim.cmd([[
  autocmd FileType lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
]])

vim.api.nvim_set_keymap('n', '<C-l>', ':noh<CR>', { noremap = true, nowait = true, silent = true })
