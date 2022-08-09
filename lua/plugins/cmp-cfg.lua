local cmp = require 'cmp'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup(
  {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    mapping = cmp.mapping.preset.insert(
      {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm(
          {select = false, behavior = cmp.ConfirmBehavior.Replace}
        ),
        ['<Tab>'] = cmp.mapping.complete(),
        --[[ ["<Tab>"] = cmp.mapping(
          function(fallback)
            if vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, {"i", "s"}
        ), ]]

        --[[ ["<S-Tab>"] = cmp.mapping(
          function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, {"i", "s"}
        ) ]]
      }
    ),
    sources = cmp.config.sources(
      {
        {name = 'copilot'},
        {name = 'nvim_lsp'},
        {name = 'cmp_tabnine'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'buffer'}
      }
    ),
    view = {entries = 'native'},
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "",
            nvim_lsp = "",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            cmp_tabnine = "",
            copilot = ""
          })
        }
      )
    },
    experimental = {ghost_text = true}
  }
)

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local tabnine = require('cmp_tabnine.config')

tabnine:setup({})
