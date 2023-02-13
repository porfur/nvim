local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "op.lsp.mason"
require("op.lsp.handlers").setup()
require "op.lsp.null-ls"
-- require "op.lsp.prettier"
