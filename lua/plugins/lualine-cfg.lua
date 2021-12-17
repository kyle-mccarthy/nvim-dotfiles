local theme = require 'lualine.themes.onedark'

theme.normal.c.bg = '#262A34'

require'lualine'.setup {
  options = {theme = theme, section_separators = '', component_separators = ''},
  sections = {
    lualine_b = {'branch', 'diff'},
    lualine_x = {{'diagnostics', sources = {'nvim_diagnostic'}}}
  }
}
