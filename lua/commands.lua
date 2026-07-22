-- NOTE: Autocmd (autocommand): a command automatically triggered on specific events
-- (e.g., file yank, buffer read).
-- Groups: named sets of autocmds used to organize, manage, and clear related autocmds together.
-- Defining a group inside the autocmd options tells Neovim which group this autocmd belongs to,
-- enabling easy updates or removal of the autocmd as part of that group and preventing duplicates.
-- --
-- So this pattern:
--   group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
-- does two things:
--   1. Creates or reuses the augroup named 'highlight-yank'
--   2. Passes its ID to the group field of the autocmd options
--   3. Clears old autocmds to avoid duplicates
-- This tells Neovim:
-- "Put this autocmd inside the highlight-yank group
-- so it can be managed together with others in the same group."

local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
local create_user_command = vim.api.nvim_create_user_command

-- Expose Neovim server
-- vim.fn.serverstart("/tmp/nvim-server")

-- [[ AUTOCOMMANDS: START ]]

-- create_autocmd("TermEnter", {
--   desc = 'Add relative numbers to terminals',
--   group = create_augroup('relativenumber-terminal', { clear = true }),
--   callback = function()
--     vim.wo.number = true
--     vim.wo.relativenumber = true
--   end,
-- })

create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = create_augroup('highlight-yank', { clear = true }),
  callback = function()
    -- Use built-in highlight (default 'IncSearch', 200ms)
    vim.highlight.on_yank {
      higroup = 'IncSearch', -- Can be changes to other ex: 'Visual'
      timeout = 200,
    }
  end,
})

create_autocmd({ 'FileType' }, {
  desc = 'Bind [q] to specified filetypes',
  group = create_augroup('q-to-quit', { clear = true }),
  pattern = { 'qf', 'lf', 'help', 'man', 'lspinfo', 'spectre_panel' },
  callback = function()
    vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true })
  end,
})

create_autocmd({ 'FileType' }, {
  desc = 'Enable text wrap and spell on specified filetypes',
  group = create_augroup('enable-text-wrap-and-spell', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

create_autocmd({ 'VimResized' }, {
  desc = 'Make windows equaly high and wide after resize',
  group = create_augroup('equal-size-windows', { clear = true }),
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

create_autocmd({ 'CmdwinEnter' }, {
  desc = 'Add keymap to quit CmdWindow with C-q',
  group = create_augroup('quit-cmdwin-keymap', { clear = true }),
  callback = function()
    vim.keymap.set({ 'n', 'i' }, '<C-q>', '<Esc>:quit<CR>', { buffer = true })
  end,
})

create_autocmd('VimLeavePre', {
  desc = 'Save session on quit and close Neotree',
  group = create_augroup('quit-neovim', { clear = true }),
  callback = function()
    pcall(function()
      vim.cmd 'Neotree close'
    end)
    -- Save session to a specific file, e.g., "Session.vim" in current dir
    vim.cmd 'mksession! Session.vim'
  end,
})

create_autocmd('LspAttach', {
  group = create_augroup('lsp-attach', { clear = true }),
  callback = require 'keymaps.lsp-keymaps',
})
-- [[ AUTOCOMMANDS: END ]]

-- -- =============================================================================

-- [[ USER COMMANDS: START ]]
-- Defines :RenameInCmdWindow user command:
--   + Creates a one-time autocmd on CmdlineEnter that:
--       - Sends <C-f> to open CmdWin
--       - Moves cursor to start of word
--   + Then triggers LSP rename (which opens Cmdline, triggering the autocmd)
create_user_command('OPRename', function()
  create_autocmd('CmdlineEnter', {
    desc = 'Open the CmdWindow on lsp rename',
    once = true, -- Makes the autocmd one-time to avoid repeat triggers
    callback = function()
      -- <C-f> inside the CmdLine opens the CmdWindow
      -- Get termcode for <C-f> (open command-line window)
      local key = vim.api.nvim_replace_termcodes('<C-f>', true, false, true)
      vim.api.nvim_feedkeys(key, 'c', false) -- Simulates <C-f>
      vim.api.nvim_feedkeys('0', 'n', false) -- Simulates 0 (begining of line)
    end,
  })
  vim.lsp.buf.rename() -- Call rename and trigger the defined autocmd
end, { desc = 'LSP Rename in command window with cursor at the start' })

-- [[ USER COMMANDS: END ]]
