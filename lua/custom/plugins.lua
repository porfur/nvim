return function(use)
  -------------------------------------------------------------------
  -- Which key
  -------------------------------------------------------------------
  use({ "folke/which-key.nvim", config = function() require("which-key").setup({}) end })

  -------------------------------------------------------------------
  -- Vim surround
  -------------------------------------------------------------------
  use({ "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function() require("nvim-surround").setup({})
    end })

  -------------------------------------------------------------------
  -- NeoTree
  -------------------------------------------------------------------
  use({ "nvim-neo-tree/neo-tree.nvim", branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    } })

  -------------------------------------------------------------------
  -- Ranger file browser
  -------------------------------------------------------------------
  use({ 'francoiscabrol/ranger.vim', requires = { 'rbgrouleff/bclose.vim' } })

  -------------------------------------------------------------------
  -- Telescope file browser
  -------------------------------------------------------------------
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  require('telescope').load_extension "file_browser"
  --
  -------------------------------------------------------------------
  -- Tmux Navigator
  -------------------------------------------------------------------

  use({ 'christoomey/vim-tmux-navigator' })

  -------------------------------------------------------------------
  -- Hilight occurences of word under cursor
  -------------------------------------------------------------------
  use({ 'RRethy/vim-illuminate' })

  -------------------------------------------------------------------
  -- LazyGit
  -------------------------------------------------------------------
  use({ 'kdheepak/lazygit.nvim' })


  -------------------------------------------------------------------
  -------------------------------------------------------------------
end
