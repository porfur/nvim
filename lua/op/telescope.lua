local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

telescope.setup {
  defaults = {
    path_display = { 'smart' },
    file_ignore_patterns = { '.git/', 'node_modules' },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [f]iles' })
vim.keymap.set('n', '<leader>sF', builtin.git_files, { desc = '[S]earch Git [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sW', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sw', builtin.live_grep, { desc = '[S]earch [w]ord by Grep' })
vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
