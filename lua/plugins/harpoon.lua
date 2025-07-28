return {
  -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
      event = 'VeryLazy',
  config = function ()
local map = vim.keymap.set
local harpoon = require("harpoon")

local add = function ()
return function ()harpoon:list():add()end
end

local select= function(index)
return function ()harpoon:list():select(index)end
end

local next = function()
return function()harpoon:list():next()end
end

local prev = function()
return function()harpoon:list():prev()end
end

 local toggle = function()
   return function()harpoon.ui:toggle_quick_menu(harpoon:list())end
 end

-- REQUIRED
harpoon:setup()
-- REQUIRED

    map('n', '<leader>m', add(), { desc = 'Harpoon [m]ark' })
    map('n', '<leader>M', toggle(), { desc = 'Harpoon [M]enu' })
    map('n', '<leader>n', next(), { desc = 'Harpoon [n]ext' })
    map('n', '<leader>p', prev(), { desc = 'Harpoon [p]revious' })
    map('n', '<leader>h', select(1), { desc = 'Harpoon to file 1' })
    map('n', '<leader>j', select(2), { desc = 'Harpoon to file 2' })
    map('n', '<leader>k', select(3), { desc = 'Harpoon to file 3' })
    map('n', '<leader>l', select(4), { desc = 'Harpoon to file 4' })
    map('n', '<leader>;', select(5), { desc = 'Harpoon to file 5' })
    map('n', "<leader>'", select(6), { desc = 'Harpoon to file 6' })
end

}
