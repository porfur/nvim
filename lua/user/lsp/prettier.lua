local status_ok, prettier = pcall(require, 'prettier')
if not status_ok then
  return
end

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },

		["null-ls"] = {
			condition = function()
				return prettier.config_exists({
					-- if `false`, skips checking `package.json` for `"prettier"` key
					check_package_json = true,
				})
			end,
			runtime_condition = function(params)
				-- return false to skip running prettier
				return true
			end,
			timeout = 5000,
		},

	-- By default these options are only used if prettier config file is not found.
	-- If you want to change that behavior, you can use the following option:
	cli_options = {
		arrow_parens = "always",
		bracket_spacing = true,
		bracket_same_line = true,
		embedded_language_formatting = "auto",
		end_of_line = "lf",
		html_whitespace_sensitivity = "css",
		jsx_bracket_same_line = false,
		jsx_single_quote = false,
		print_width = 80,
		prose_wrap = "preserve",
		quote_props = "as-needed",
		semi = true,
		single_attribute_per_line = false,
		single_quote = true,
		tab_width = 2,
		trailing_comma = "es5",
		use_tabs = false,
		vue_indent_script_and_style = false,
	}
})
