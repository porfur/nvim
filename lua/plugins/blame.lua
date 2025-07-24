return {
 -- https://github.com/FabijanZulj/blame.nvim
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    vim.keymap.set('n','<leader>gB',':BlameToggle<CR>',{desc='[g]it [B]lame toggle'})
    end,
}
