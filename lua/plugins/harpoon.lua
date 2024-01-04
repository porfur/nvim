-- https://github.com/ThePrimeagen/harpoon
-- Blazingly fast buffer navigation
 return {
    'ThePrimeagen/harpoon',
    config = function()
      local mark = require('harpoon.mark')
      local ui = require("harpoon.ui")
      vim.keymap.set('n', '<leader>m', mark.add_file, { desc = 'Harpoon [m]ark' })
      vim.keymap.set('n', '<leader>M', ui.toggle_quick_menu, { desc = 'Harpoon [M]enu' })
      vim.keymap.set('n', '<leader>n', ui.nav_next, { desc = 'Harpoon [n]ext' })
      vim.keymap.set('n', '<leader>p', ui.nav_prev, { desc = 'Harpoon [p]revious' })

      vim.keymap.set('n', '<leader>h', function() ui.nav_file(1) end, { desc = 'Harpoon to file 1' })
      vim.keymap.set('n', '<leader>j', function() ui.nav_file(2) end, { desc = 'Harpoon to file 2' })
      vim.keymap.set('n', '<leader>k', function() ui.nav_file(3) end, { desc = 'Harpoon to file 3' })
      vim.keymap.set('n', '<leader>l', function() ui.nav_file(4) end, { desc = 'Harpoon to file 4' })
      vim.keymap.set('n', '<leader>;', function() ui.nav_file(5) end, { desc = 'Harpoon to file 5' })
      vim.keymap.set('n', "<leader>'", function() ui.nav_file(6) end, { desc = 'Harpoon to file 6' })
    end
  }
