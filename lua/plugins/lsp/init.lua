-- Order all lsp related plugins
-- The order of these items is important
-- Check out the link for the documentation
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/lazy-loading-with-lazy-nvim.md

return{
  require('plugins.lsp.lspzero') ,
  require('plugins.lsp.mason') ,
  require('plugins.lsp.cmp') ,
  require('plugins.lsp.nvim-lsp-config') ,
}
