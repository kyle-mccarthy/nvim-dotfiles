require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').update_capabilities(
                       vim.lsp.protocol.make_client_capabilities()
                     )

lspconfig.tsserver.setup {
  capabilities = capabilities,
  flags = {debounce_text_changes = 150},
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  settings = {format = {enable = false}},
  flags = {debounce_text_changes = 250}
}

lspconfig.tailwindcss.setup {filetypes = {"javascriptreact", "typescriptreact"}}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,

  settings = {
    Lua = {runtime = {version = 'LuaJIT'}, diagnostics = {globals = {'vim'}}}
  }
}

lspconfig.efm.setup {
  capabilities = capabilities,
  filetypes = {'lua'},
  settings = {
    init_options = {documentFormatting = true},
    languages = {
      lua = {
        {
          formatCommand = 'lua-format -c ~/.config/lua-format.yaml -i',
          formatStdin = true
        }
      }
    }
  },

  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
  end
}

lspconfig.pyright.setup {capabilities = capabilities}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {rustfmt = {extraArgs = {"+nightly"}}}
}

lspconfig.dockerls.setup {capabilities = capabilities}

--[[ require('rust-tools').setup(
  {
    tools = {
      -- hover_actions = {auto_focus = true},
      inlay_hints = {
        -- only_current_line = true,
        -- only_current_line_autocmd = "CursorMoved"
        show_variable_name = true
      }
    },
    server = {capabilities = capabilities}
  }
) ]]

--[[ lspconfig.rust_analyzer.setup{
    settings = {
      ["rust-analyzer"] = {
                rustfmt = {extraArgs = {"+nightly"}},
        procMacro = {
          ignored = {["async-trait"] = {"async_trait"}, ["tokio"] = {"test"}}
        }
      }
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }

  require('rust-tools').setup(
    {
      tools = {
        hover_actions = {auto_focus = true},
        inlay_hints = {
          only_current_line = true,
          only_current_line_autocmd = "CursorMoved"
        }
      },
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts)
    }
  ) ]]

-- on ready callback for the installer
--[[ lsp_installer.on_server_ready(
  function(server)
    local opts = {}

    -- let rust tools handle the config
    if server.name == "rust_analyzer" then
      setup_rust_analyzer(server)
      return
    end

    --[[ opts.capabilities = require('cmp_nvim_lsp').update_capabilities(
                          vim.lsp.protocol.make_client_capabilities()
                        ) ]]

--[[ if lspconfig.[server.name] ~= nil then
      lspconfig.[server.name](opts)
    end

    server:setup(opts)
  end
) ]]

-- commands
local map = vim.api.nvim_set_keymap
local options = {noremap = true, silent = false}

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)

vim.api.nvim_create_user_command(
  'ShowError', function()
    local max_width = math.floor((40 * 2) * (vim.o.columns / (40 * 2 * 16 / 9)))
    vim.diagnostic.open_float(
      {
        focusable = false,
        max_width = max_width,
        border = "rounded",
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None'
      }
    )
  end, {}
)

map('n', '<leader>e', '<cmd>ShowError<CR>', options)

-- cosmetics
vim.fn.sign_define(
  'DiagnosticSignError', {text = '', texthl = 'DiagnosticsDefaultError'}
) -- error
vim.fn.sign_define(
  'DiagnosticSignWarning', {text = '', texthl = 'DiagnosticsDefaultWarning'}
) -- warning
vim.fn.sign_define(
  'DiagnosticSignHint', {text = '', texthl = 'DiagnosticsDefaultHint'}
) -- hint
vim.fn.sign_define(
  'DiagnosticSignInformation', {
    text = '',
    texthl = 'DiagnosticsDefaultInformation'
  }
) -- information

-- formatting
vim.api.nvim_command([[command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync(nil, 5000)]])
vim.api.nvim_command([[command! -nargs=0 Fmt :lua vim.lsp.buf.formatting_sync(nil, 5000)]])
vim.api.nvim_set_keymap(
  'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting(nil, 5000)<CR>',
  {noremap = true, silent = true, nowait = true}
)
