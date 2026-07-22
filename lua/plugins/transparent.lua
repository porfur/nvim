return {
  'xiyaowong/transparent.nvim',

  config = function ()
    require('transparent').setup({})
    -- vim.cmd 'TransparentEnable'
    vim.keymap.set('n','<leader><Tab>t',':TransparentToggle<CR>',{desc='[t]ransparent toggle'})
  end
}
