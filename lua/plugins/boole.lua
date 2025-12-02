return {
  -- https://github.com/nat-414/boole.nvim
  'nat-418/boole.nvim'
  ,
  config = function()
    require('boole').setup({
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
      },
      -- User defined loops
      additions = {
        { 'foo', 'bar', 'baz' },
        { 'tic', 'tac', 'toe' },
        { 'open', 'close' },
        { 'opened', 'closed' },
        { 'true', 'false', 'null', 'undefined' },

        -- Below not working
        { '||',  '&&' },
        { '!==', "===" }

      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        { 'foo',    'bar',    'baz' },
        { 'tic',    'tac',    'toe' },
        { 'open', 'close' },
        { 'opened', 'closed' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      }
    })
  end
}
