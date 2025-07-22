return  {
  -- https://github.com/MagicDuck/grug-far.nvim
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    -- Atuocommand to change the which-key description for leader-c only in the grugfar filetype
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("WhichKeyGrufFarOverride", { clear = true }),
        pattern = { 'grug-far' },
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local wk = require("which-key")
        wk.add({ "<leader>c", desc = "[c]lose GrugFar", buffer = buf })
    end

  })
end}
