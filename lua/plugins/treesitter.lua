require('nvim-treesitter.configs').setup(
  {
    ensure_installed = 'all',
    highlight = {enable = true},
    -- incremental_selection = {enable = true},
    indent = {enable = true, disable = {"python"}},
    matchup = {enable = true},
    rainbow = {
      enable = true,
      extended_mode = true,
      disable = {"tsx"}
    }
  }
)

require('spellsitter').setup()
