return {
  config = function()
    vim.cmd 'colorscheme dracula'
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
    'oskarnurm/koda.nvim',
    'dikiaap/minimalist',
    'jpwol/thorn.nvim',
    'robertmeta/nofrils',
    'wolverian/minimal',
    'ewilazarus/preto',
    'marfisc/vorange',
    'lunacookies/vim-mayanfog',
    'rektrex/micro.vim',
    'meain/hima-vim',
    'stefanvanburen/rams',
    'alonfnt/vim-minimal',
    'mistweaverco/retro-theme.nvim',
    'jwbaldwin/oscura.nvim',
    'binbandit/achroma.nvim'
    , 'gko/oldbook-theme'
  },
}
