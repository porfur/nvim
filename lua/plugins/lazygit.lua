return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    -- optional for floating window border decoration
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', {
      silent = false,
      desc = 'Lazy [G]it',
    })
  end,
}
