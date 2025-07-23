return {
  -- https://github.com/stevearc/oil.nvim
    'stevearc/oil.nvim',
    opts = {},
  event = 'VeryLazy',
  config = function ()
    require('oil').setup({})
    vim.keymap.set('n','<leader>oo',':Oil<CR>',{desc='[o]il'})
  end
  }
