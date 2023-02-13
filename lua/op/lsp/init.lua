local neodev_status_ok, neodev = pcall(require, "neodev")
if not neodev_status_ok then
    return
end
neodev.setup({})

local lspconfig_status_ok, _ = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

require "op.lsp.mason"
require("op.lsp.handlers").setup()
require "op.lsp.null-ls"
-- require "op.lsp.prettier"
