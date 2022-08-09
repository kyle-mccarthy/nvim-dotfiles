local theme = require('onedark')

theme.setup {
  style = 'dark',
  -- transparent = true,

  colors = {
    bg0 = '#21242B',
    -- bg1 = '#31353f',
    -- bg2 = '#393f4a',
    -- bg3 = '#3b3f4c',
    -- bg_d = '#21252b'

    bg1 = '#2C3039',
    bg2 = '#373C48',
    bg3 = '#424856',
    bg_d = '#181b20',
    bg_d1 = '#1E2026',

  },
  highlights = {
    NvimTreeNormal = { bg = '$bg_d1'},
    NvimTreeVertSplit = { fg = '$bg_d1', bg = '$bg_d1'},
    NvimTreeEndOfBuffer = { bg = '$bg_d1'},
    polarSemicolon = { fg = '$fg' },

    DiagnosticUnderlineError = { fg = '$red', curl = true }
  }
}

theme.load()
