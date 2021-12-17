require('nvim-autopairs').setup({ check_ts = true })

local get_rule = require('nvim-autopairs').get_rule

get_rule("'")[1]:with_pair(
  function()
    return vim.bo.filetype ~= "rust"
  end
)

