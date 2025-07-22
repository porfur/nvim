return {
  -- https://github.com/kdheepak/lazygit.nvim
  'kdheepak/lazygit.nvim',
  config = function()
    vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', {desc= 'Lazy [G]it'})
  end

}
