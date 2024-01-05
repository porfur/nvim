-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

local bind = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = function(desc)
      return { buffer = event.buf, silent = false, desc = desc or 'NEED DESC' }
    end
    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    bind('n', '<leader>cK', function()
      vim.lsp.buf.hover()
    end, opts '[K] Hover info')
    bind('n', '<leader>cgg', function()
      vim.lsp.buf.signature_help()
    end, opts 'Si[g]nature help (alias: <C-g>)')
    bind('n', '<C-g>', function()
      vim.lsp.buf.signature_help()
    end, opts 'Si[g]nature help')
    bind('n', '<leader>cgd', function()
      vim.lsp.buf.definition()
    end, opts '[d]efinition')
    bind('n', '<leader>cgl', function()
      vim.diagnostic.open_float()
    end, opts 'Diagnostics in F[l]oating window')
    bind('n', '<leader>cgD', function()
      vim.lsp.buf.declaration()
    end, opts '[D]eclaration')
    bind('n', '<leader>cgi', function()
      vim.lsp.buf.implementation()
    end, opts '[i]mplementation')
    bind('n', '<leader>cgo', function()
      vim.lsp.buf.type_definition()
    end, opts 'Symb[o]l type definition')
    bind('n', '<leader>cgr', require('telescope.builtin').lsp_references, opts '[r]eferences')
    bind('n', 'gr', require('telescope.builtin').lsp_references, opts 'Go to [r]eferences')
    bind('n', '<leader>c[d', function()
      vim.diagnostic.goto_prev(_)
    end, opts 'Previous Diagnostic')
    bind('n', '<leader>c]d ', function()
      vim.diagnostic.goto_next()
    end, opts 'Next Diagnostic')
    bind('n', '<leader>cr', function()
      vim.lsp.buf.rename()
    end, opts '[R]ename')
    bind('n', '<leader>ca', function()
      vim.lsp.buf.code_action()
    end, opts '[A]ction')
    bind('n', '<leader>f', function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name ~= 'tsserver'
        end,
        async = false,
        timeout_ms = 10000,
      }
    end, opts '[f]ormat')
    bind('n', '<leader>cf', function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name ~= 'tsserver'
        end,
        async = false,
        timeout_ms = 10000,
      }
    end, opts '[f]ormat')
    -- more keybindings...
    bind('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts '[S]ymbols')
    bind('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts '[a]dd Folder')
    bind('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts '[r]emove Folder')
    bind('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts '[l]ist folder')
  end,
})

local kind_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}
local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer', -- Optional
    'hrsh7th/cmp-path', -- Optional
    'saadparwaiz1/cmp_luasnip', -- Optional
    'hrsh7th/cmp-nvim-lua', -- Optional
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'rafamadriz/friendly-snippets',
    'j-hui/fidget.nvim', -- Optional
    'nvimtools/none-ls.nvim',
  },
  config = function()
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local default_setup = function(server)
      require('lspconfig')[server].setup {
        capabilities = lsp_capabilities,
      }
    end

    require('mason').setup {}
    require('mason-lspconfig').setup {
      ensure_installed = { 'eslint' },
      handlers = { default_setup },
    }

    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
      },
    }

    local luasnip = require 'luasnip'
    require('luasnip/loaders/from_vscode').lazy_load()
    local cmp = require 'cmp'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        --     -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
      },
      formatting = {
        expandable_indicator = true,
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.kind = kind_icons[vim_item.kind]
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[nvim_lua]',
            buffer = '[buffer]',
            path = '[path]',
            nvim_lsp_signature_help = '[LSP-Signature]',
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
      },
      select_behavior = 'insert',
      experimental = {
        ghost_text = false,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }
  end,
}
