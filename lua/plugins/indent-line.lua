
return {
  { -- Add indentation guides even on blank lines
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      debounce = 500,
      indent = { char = '▏', smart_indent_cap = true },
      whitespace = { highlight = { 'Whitespace', 'NonText' } },
      exclude = {
        filetypes = {
          'help',
          'packer',
        },
        buftypes = { 'terminal', 'nofile' },
      },
    },
  },
}
