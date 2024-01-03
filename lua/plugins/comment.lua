-- https://github.com/numToStr/Comment.nvim
-- Commenting motions including typescript dependency

return {
 -- enable = false, -- Uncomment to disable
    'numToStr/Comment.nvim',

 dependencies =    { 
    --https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    'JoosepAlviste/nvim-ts-context-commentstring'
    },


config=function() pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() end,

    opts = {
        -- add any options here
    },
    lazy = false,
}
