-- https://github.com/numToStr/Comment.nvim
-- Commenting motions including typescript dependency

return {
  'numToStr/Comment.nvim',
  lazy = false,
  dependencies = {
    --https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    'JoosepAlviste/nvim-ts-context-commentstring'
  },
  -- TODO: Figure out how to use this pre hook with lazy
  -- config=function() pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() end,
}
