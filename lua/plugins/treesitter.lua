return {

  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  init = function ()
-- Init function coppied from 
-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/8621
    vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if not vim.treesitter.language.add(lang) then
      -- this stupid tracking is here only because
      -- they have added warnings on absent parsers
      local available = vim.g.ts_available
        or require("nvim-treesitter").get_available()
      if not vim.g.ts_available then
        vim.g.ts_available = available
      end
      if vim.tbl_contains(available, lang) then
        require("nvim-treesitter").install(lang)
      end
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      -- this is an experimental feature
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end
  end,
})
  end
}


-- TODO: Old Config needs a match
-- return {
-- 
--             -- https://github.com/nvim-treesitter/nvim-treesitter
--   -- TODO: Learn what setting are usefull below and remove what is not needed
--   'nvim-treesitter/nvim-treesitter',
--   lazy = false,
--   branch='main',
--   build = ':TSUpdate',
--             config = function()
--               local configs = require 'nvim-treesitter.configs'
--               configs.setup {
--                 TSConfig = {},
--       modules = {},
--       auto_install = true,
--                 ensure_installed = { 'c', 'vim', 'lua', 'markdown', 'markdown_inline', 'bash', 'python', 'javascript', 'typescript', 'html', 'css', 'scss' },
--                 ignore_install = { '' },
--               sync_install = false,
--       highlight = {
--         enable = true,
--         -- disable = { "css" }, -- list of language that will be disabled
--       },
--       autopairs = {
--         enable = true,
--       },
--       indent = { enable = true, disable = { 'python' } },
-- 
--       incremental_selection = {
--         enable = true,
--         keymaps = {
--           init_selection = '<C-space>',
--           node_incremental = '<C-space>',
--           -- scope_incremental = '<C-s>',
--           node_decremental = '<backspace>',
--         },
--       },
--       textobjects = {
--         select = {
--           enable = true,
--           lookahead = true,   -- Automatically jump forward to textobj, similar to targets.vim
-- 
--           keymaps = {
--             -- You can use the capture groups defined in textobjects.scm
--             ['aa'] = '@parameter.outer',
--             ['ia'] = '@parameter.inner',
--             ['af'] = '@function.outer',
--             ['if'] = '@function.inner',
--             ['ac'] = '@class.outer',
--             ['ic'] = '@class.inner',
--           },
--         },
--         move = {
--           enable = true,
--           set_jumps = true,   -- whether to set jumps in the jumplist
--           goto_next_start = {
--             [']m'] = '@function.outer',
--             [']]'] = '@class.outer',
--           },
--           goto_next_end = {
--             [']M'] = '@function.outer',
--             [']['] = '@class.outer',
--           },
--           goto_previous_start = {
--             ['[m'] = '@function.outer',
--             ['[['] = '@class.outer',
--           },
--           goto_previous_end = {
--             ['[M'] = '@function.outer',
--             ['[]'] = '@class.outer',
--           },
--         },
--         swap = {
--           enable = true,
--           swap_next = {
--             ['<leader>a'] = '@parameter.inner',
--           },
--           swap_previous = {
--             ['<leader>A'] = '@parameter.inner',
--           },
--         },
--       },
--     }
--   end,
-- }
