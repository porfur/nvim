-- https://github.com/VonHeikemen/lsp-zero.nvim
-- Collection of functions that will help you setup Neovim's LSP client,
-- so you can get IDE-like features with minimum effort.
--
return{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  }
