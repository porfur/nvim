
return {
  -- Treesitter Context --
  -- Show function context at top of the screen when function is long
  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  'nvim-treesitter/nvim-treesitter-context',
  opts = {},
  config = function()
    local toggle = function ()
         vim.cmd 'TSContext toggle'
    vim.cmd 'hi TreesitterContextBottom gui=underline guisp=White'
    vim.cmd 'hi TreesitterContextLineNumberBottom gui=underline guisp=Grey'
    end
    -- Adds underline to context regardless of the colorscheme
    vim.keymap.set('n', '<leader>cc',toggle, { desc = 'TS [c]ontext toggle' })
    vim.keymap.set('n', '<leader><Tab>c',toggle, { desc = 'TS [c]ontext toggle' })
  end,
}
