local cmp = require 'cmp'

cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
      ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources(
      {
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'cmp_tabnine'},
        {name = 'buffer'},
        {name = 'vsnip'}
      }
    ),
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder"
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]"
          })
        }
      )
    }
  }
)
