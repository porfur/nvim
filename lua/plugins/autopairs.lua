-- https://github.com/windwp/nvim-autopairs
-- Close pairs of parantheses automatically

  return {
 -- enable = false, -- Uncomment to disable
    "windwp/nvim-autopairs",

    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      check_ts = true,     -- treesitter integration
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      }
    },

    config = function()
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  }
