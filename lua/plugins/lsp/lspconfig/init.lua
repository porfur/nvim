return {
	'neovim/nvim-lspconfig',
	cmd = {'LspInfo', 'LspInstall', 'LspStart'},
	event = {'BufReadPre', 'BufNewFile'},
	dependencies = {
		{'hrsh7th/cmp-nvim-lsp'},
		{'williamboman/mason-lspconfig.nvim'},
	},
	config = require('plugins.lsp.lspconfig.config')
}
