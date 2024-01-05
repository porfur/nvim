-- https://github.com/lewis6991/gitsigns.nvim
-- Git decorations and actions

return {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage git hunk' })
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>gB',  gs.blame_line , { desc = 'git blame line' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>gD', function() gs.diffthis '~' end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>gd', gs.toggle_deleted, { desc = 'toggle git show deleted' })

      end,
    }}
