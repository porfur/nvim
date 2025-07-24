return {
  -- TreeSJ --
  -- Toggles blocks of code from single to multi line
  -- https://github.com/Wansmer/treesj
  'Wansmer/treesj',
  -- keys = { '<space>o', '<space>-', '<space>+' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup { use_default_keymaps = false }
    vim.keymap.set('n', '<leader>co', ':TSJToggle<CR>', { desc = 'Toggle code block' })
    vim.keymap.set('n', '<leader><Tab>c', ':TSJToggle<CR>', { desc = '[T]oggle [c]ode block' })
  end,
}
