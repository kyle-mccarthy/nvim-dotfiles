vim.o.completeopt = 'menu,menuone,noselect,noinsert'
vim.o.mouse = 'nv'
vim.o.number = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.clipboard = 'unnamed'
vim.o.spell = false
vim.o.spelllang = 'en_us'
vim.o.termguicolors = true
-- vim.o.background = 'dark'
vim.o.showcmd = true
vim.o.signcolumn = 'number'
vim.o.swapfile = false
vim.o.foldenable = false
vim.o.hidden = true
vim.opt.formatoptions:remove('t')

vim.g.python_host_prog = '/Users/kylemccarthy/.pyenv/versions/nvim2/bin/python'
vim.g.python3_host_prog = '/Users/kylemccarthy/.pyenv/versions/nvim3/bin/python'

require('plugins')
require('plugins.cmp-cfg')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.lualine-cfg')
require('plugins.trouble-cfg')
require('plugins.autopairs')
require('plugins.kommentary')
require('plugins.telescope-cfg')
require('plugins.null-ls-cfg')
require('plugins.indent-blankline-cfg')
require('plugins.onedark-cfg')
require('plugins.nvim-tree-cfg')
require('plugins.bufferline-cfg')
require('plugins.dressing-cfg')
require('plugins.fidget-cfg')
-- require('plugins.dap-cfg')

require('settings')

vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]


