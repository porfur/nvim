return {
  config = function()
    vim.cmd 'colorscheme onedark'
  end,
  priority = 1000, -- Ensure it loads first

  'cpea2506/one_monokai.nvim',
  dependencies = {
    "ellisonleao/gruvbox.nvim",
    'EdenEast/nightfox.nvim',
    "olimorris/onedarkpro.nvim",
    'romgrk/doom-one.vim',
    'cpea2506/one_monokai.nvim',
    'bluz71/vim-moonfly-colors',
    'navarasu/onedark.nvim',
    'maxmx03/solarized.nvim',
    'catppuccin/nvim',
    'Mofiqul/dracula.nvim',
    'romgrk/doom-one.vim',
    'bluz71/vim-moonfly-colors',
    { 'uloco/bluloco.nvim', dependencies = { 'rktjmp/lush.nvim' }, },
  },
}
