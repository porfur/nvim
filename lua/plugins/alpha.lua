return {
  -- Adds a start up screen instead of empty buffer
  -- https://github.com/goolord/alpha-nvim
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local startify = require("alpha.themes.startify")
    -- available: devicons, mini, default is mini
    -- if provider not loaded and enabled is true, it will try to use another provider
    startify.file_icons.enabled = true

    startify.section.bottom_buttons.val = {
      startify.button("l", "Load Session.vim", "<cmd>so Session.vim <CR>"),
      startify.button("L", "Load OPSession.vim", "<cmd>so OPSession.vim! <CR>"),
      startify.button("q", "Quit", "<cmd>q <CR>"),
    }

    require("alpha").setup(startify.config)
  end,
}
