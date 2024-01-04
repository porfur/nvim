-- This file returns the config function for lspconfig

    local bind = vim.keymap.set

-- [[RETURN CONFIG]]
return function()
  -- This is where all the LSP shenanigans will live
  local lsp_zero = require 'lsp-zero'
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    local opts = function(desc)
      return { buffer = bufnr, silent = true, desc = desc or 'NEED DESC' }
    end

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
    bind('n', '<leader>cf', function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name ~= 'tsserver'
        end,async=false, timeout_ms =10000
      }
    end, opts '[f]ormat')
    bind('n', '<leader>f', function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name ~= 'tsserver'
        end,async=false, timeout_ms =10000
      }
    end, opts '[f]ormat')
    
    -- more keybindings...
    bind('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts '[S]ymbols')
    bind('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts '[a]dd Folder')
    bind('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts '[r]emove Folder')
    bind('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts '[l]ist folder')
    -- to learn the available actions
    lsp_zero.default_keymaps { buffer = bufnr }
  end)

  require('mason-lspconfig').setup {
    ensure_installed = {},
    handlers = {
      lsp_zero.default_setup,
      lua_ls = function()
        -- (Optional) Configure lua language server for neovim
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
    },
  }
end
