return function(use)
  use({ "folke/which-key.nvim",
    config = function() require("which-key").setup({})
    end })

    use ('Mofiqul/dracula.nvim')

  use({ "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function() require("nvim-surround").setup({})
    end })

  -- Unless you are still migrating, remove the deprecated commands from v1.x
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  use( {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }})

  --Ranger
 use( { 'francoiscabrol/ranger.vim' } )
  --Ranger Dependency
 use( { 'rbgrouleff/bclose.vim' } )
  --Telescope file browser
use ( { "nvim-telescope/telescope-file-browser.nvim" } )
 require( 'telescope' ).load_extension "file_browser"
-- Tmux Navigator
 use( { 'christoomey/vim-tmux-navigator' } )
--Hilight word occurences under the cursor
  use( { 'RRethy/vim-illuminate' } )

--Lazygit
  use( { 'kdheepak/lazygit.nvim' } )

end
