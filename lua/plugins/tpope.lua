return   {
    -- TODO Learn to use these or remove them
    { -- GIT COMMANDS --
      -- https://github.com/tpope/vim-fugitive
      'tpope/vim-fugitive',
    config =function ()
        vim.keymap.set('n', '<leader>gx', '<cmd>GBrowse<CR>', {desc= 'Git Browse'})
    end
    },
    { -- GITHUB INTEGRATION
      -- https://github.com/tpope/vim-rhubarb
      'tpope/vim-rhubarb',
    },
  }

