require('bufferline').setup(
  {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "NvimTreeNormal",
          text_align = "left"
        }
      }
    }
  }
)

