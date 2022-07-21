vim.cmd(
  [[
  autocmd FileType lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

]]
)

vim.api.nvim_set_keymap(
  'n', '<C-l>', ':noh<CR>', {noremap = true, nowait = true, silent = true}
)

-- eslint fix all on \F

vim.api.nvim_set_keymap(
  'n', '<leader>F', ':EslintFixAll<CR>', {silent = true, nowait = true}
)

vim.api.nvim_set_keymap(
  'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    silent = true,
    nowait = true
  }
)

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent=true})

vim.diagnostic.config({ virtual_text = false })

