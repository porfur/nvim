-- https://github.com/hrsh7th/nvim-cmp
-- A completion engine plugin for neovim written in Lua. 
-- Completion sources are installed from external repositories and "sourced".
--
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {

		-- https://github.com/hrsh7th/cmp-buffer
		-- nvim-cmp source for buffer words.
		'hrsh7th/cmp-buffer' 
		,       

		-- https://github.com/L3MON4D3/LuaSnip
		-- Snippets
		'L3MON4D3/LuaSnip',

      'hrsh7th/cmp-buffer',       -- Optional
      'hrsh7th/cmp-path',         -- Optional
      'saadparwaiz1/cmp_luasnip', -- Optional
      'hrsh7th/cmp-nvim-lua',     -- Optional
      'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    config = require('plugins.lsp.cmp.config')
  }
