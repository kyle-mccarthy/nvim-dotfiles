local cb = function(use)
  use 'wbthomason/packer.nvim'

  -- fzf
  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  use {'ojroques/nvim-lspfuzzy'}

  -- ui
  use {'kyazdani42/nvim-web-devicons'}
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {'navarasu/onedark.nvim'}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}
  use {'folke/trouble.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {'lukas-reineke/indent-blankline.nvim'}
  use {'rhysd/conflict-marker.vim'}
  use {'stevearc/dressing.nvim'}
  use {'j-hui/fidget.nvim'}

  -- lsp
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/mason.nvim'}
  use {'williamboman/mason-lspconfig.nvim'}
  use {'nvim-lua/lsp-status.nvim'}
  use {'onsails/lspkind-nvim'}

  -- completion
  use {'hrsh7th/nvim-cmp'}
  -- use {'hrsh7th/cmp-vsnip', requires = 'hrsh7th/nvim-cmp'}
  -- use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use {
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }
  use('simrat39/inlay-hints.nvim')

  -- snippets
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}

  use {'windwp/nvim-autopairs'}
  use {'simrat39/rust-tools.nvim'}
  use {'andymass/vim-matchup'}
  use {'jose-elias-alvarez/null-ls.nvim'}
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = {{'nvim-lua/plenary.nvim'}, {'nvim-treesitter/nvim-treesitter'}}
  }
  -- use {"github/copilot.vim"}
  use {
    "zbirenbaum/copilot.lua",
    event = {"VimEnter"},
    config = function()
      vim.defer_fn(
        function()
          require("copilot").setup()
        end, 100
      )
    end
  }
  use {"zbirenbaum/copilot-cmp", module = "copilot_cmp"}

  -- utils
  use {'nvim-lua/plenary.nvim'}
  use {'tpope/vim-abolish'} -- better substitution
  use {'tpope/vim-surround'}
  use {'b3nj5m1n/kommentary'}

  -- treesitter
  use {'p00f/nvim-ts-rainbow'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'windwp/nvim-ts-autotag'}
  use {'RRethy/nvim-treesitter-textsubjects'}
  use {'lewis6991/spellsitter.nvim'}

  -- debugger
  use 'mfussenegger/nvim-dap'
end

return require('packer').startup(cb)
