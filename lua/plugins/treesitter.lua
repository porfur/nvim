-- https://github.com/nvim-treesitter/nvim-treesitter

return {
	-- enable = false, -- Uncomment to disable
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local configs = require("nvim-treesitter.configs")
		configs.setup {
			ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "javascript", "typescript", "html", "css", "scss" }, -- put the language you want in this array
			ignore_install = { "" }, -- List of parsers to ignore installing
			sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
			highlight = {
				enable = true, -- false will disable the whole extension
				-- disable = { "css" }, -- list of language that will be disabled
			},
			autopairs = {
				enable = true,
			},
			indent = { enable = true, disable = { "python" } },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<c-space>',
					node_incremental = '<c-space>',
					scope_incremental = '<c-s>',
					node_decremental = '<c-backspace>',
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[']m'] = '@function.outer',
						[']]'] = '@class.outer',
					},
					goto_next_end = {
						[']M'] = '@function.outer',
						[']['] = '@class.outer',
					},
					goto_previous_start = {
						['[m'] = '@function.outer',
						['[['] = '@class.outer',
					},
					goto_previous_end = {
						['[M'] = '@function.outer',
						['[]'] = '@class.outer',
					},
				},
				swap = {
					enable = true,
					swap_next = {
						['<leader>a'] = '@parameter.inner',
					},
					swap_previous = {
						['<leader>A'] = '@parameter.inner',
					},
				},
			},
		}
	end
}



