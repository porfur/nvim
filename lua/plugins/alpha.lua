return   {
    -- Adds a start up screen instead of empty buffer
    -- https://github.com/goolord/alpha-nvim
    'goolord/alpha-nvim',
    dependencies = {
      -- 'nvim-tree/nvim-web-devicons',
    },

    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.enabled = false
      require("alpha").setup(
        startify.config
      )
    end,
  }
