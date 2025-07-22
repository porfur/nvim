return {

  -- {
  --   -- NOTE: Used for Neovim config only
  --   -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  --   -- used for completion, annotations and signatures of Neovim apis
  --   'folke/lazydev.nvim',
  --   ft = 'lua',
  --   opts = {
  --     library = {
  --       -- Load luvit types when the `vim.uv` word is found
  --       { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  --     },
  --   },
  -- },

  {


    -- A "data only" repo, providing basic, default
    -- Nvim LSP client configurations for various LSP servers.
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- https://github.com/mason-org/mason-lspconfig.nvim
        -- This plugin's main responsibilities are to:
        -- allow you to automatically install, and automatically enable
        -- (vim.lsp.enable()) installed servers
        --
        -- provide extra convenience APIs such as the :LspInstall command
        --
        -- provide additional LSP configurations for a few servers
        --
        -- translate between nvim-lspconfig server names and mason.nvim package names
        -- (e.g. lua_ls <-> lua-language-server)
        --
        --NOTE: Since the introduction of :h vim.lsp.config in Neovim 0.11,
        -- this plugin's feature set has been reduced.
        -- Use this plugin if you want to automatically enable installed
        -- servers (:h vim.lsp.enable()) or have access to the :LspInstall command.
        'mason-org/mason-lspconfig.nvim',
        opts = {},
      },
      {
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        -- This plugin allows you to ensure installed LSP,DAP,Linter and Formatter
        -- mason-lsp-config only accepts LSP
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          ensure_installed = {
            'ts_ls',
            'lua_ls',
            'prettierd',
            'eslint_d',
            'eslint'
          }
        }
      },
      {
        -- https://github.com/mason-org/mason.nvim
        --  Portable package manager for Neovim that runs everywhere Neovim runs.
        -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
        'mason-org/mason.nvim',
        opts = {},
      },
      {
        -- https://github.com/j-hui/fidget.nvim
        -- Extensible UI for Neovim notifications and LSP progress messages.
        'j-hui/fidget.nvim',
        opts = {},
      },
      {
        -- https://github.com/RRethy/vim-illuminate
        -- Automatically highlighting other uses of the word under the cursor using
        -- either LSP, Tree-sitter, or regex matching.
        'RRethy/vim-illuminate',
      },
    },
  }
}
