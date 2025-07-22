return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    {
      -- https://github.com/nvim-lua/plenary.nvim
      -- All the lua functions I don't want to write twice.
      'nvim-lua/plenary.nvim',
    },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      -- fzf-native is a c port of fzf. It only covers the algorithm
      -- and implements few functions to support calculating the score.
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    {
      -- https://github.com/nvim-telescope/telescope-ui-select.nvim
      -- It sets vim.ui.select to telescope.
      -- That means for example that neovim core stuff can fill the telescope picker.
      -- Example would be lua vim.lsp.buf.code_action().
      'nvim-telescope/telescope-ui-select.nvim',
    },
  },

  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'

    require('telescope').setup {
      -- All the info you're looking for is in `:help telescope.setup()`
      -- NOTE: Setting defaults to a table uses the default theme.
      -- wrapping it in require('telescope.themes').get_ivy defaults to the specified theme
      defaults = require('telescope.themes').get_ivy {
      -- defaults = {
        winblend = 10,
        layout_config = {
          width = function(_, cols, _)
            return math.ceil(cols * 1.75)
          end,
          height = function(_, _, rows)
            return math.ceil(rows * 0.75)
          end,
        },
        previewer = true,

        mappings = {
          -- TODO: See defaults and maybe remove these
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-x>'] = actions.delete_buffer,
            ['<C-space>'] = 'to_fuzzy_refine',
            ['<C-h>'] = actions.preview_scrolling_left,
            ['<C-l>'] = actions.preview_scrolling_right,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-u>'] = actions.preview_scrolling_up,
          },
          n = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-x>'] = actions.delete_buffer,
            ['<C-space>'] = 'to_fuzzy_refine',
            ['<C-h>'] = actions.preview_scrolling_left,
            ['<C-l>'] = actions.preview_scrolling_right,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-u>'] = actions.preview_scrolling_up,
          },
        },
      },
      pickers = {
        marks = {
          attach_mappings = function(prompt_bufnr, map)
            map({ 'n', 'i' }, '<C-x>', function()
              require('telescope.actions').delete_mark(prompt_bufnr)
            end, { desc = 'Delete mark' })
            return true -- Keep default mappings as well as the custom ones
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          -- Changes the default ui-select with telescope's get_cursor theme
          require('telescope.themes').get_cursor(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    local function find_config_files()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end

    local function live_grep_uu()
      builtin.live_grep { additional_args = { '-uu' } }
    end

    local function find_hidden_files()
      builtin.find_files { hidden = true, no_ignore_p = true }
    end

    local function grep_open_files()
      builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
    end

    local map = vim.keymap.set

    map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    map('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    map('n', '<leader>sc', builtin.colorscheme, { desc = '[s]earch [c]olorschemes' })
    map('n', '<leader>st', builtin.builtin, { desc = '[s]earch [t]elescope builtin' })
    map('n', '<leader>sv', find_config_files, { desc = '[s]earch neo[v]im files' })
    map('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
    map('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
    map('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch [s]tring (grep)' })
    map('n', '<leader>ss', builtin.live_grep, { desc = '[s]earch string ([g]rep)' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    map('n', '<leader>.', builtin.resume, { desc = '[S]earch [R]esume' })
    map('n', '<leader>s?', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    map('n', '<leader>?', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
    map('n', '<leader>sF', find_hidden_files, { desc = '[s]earch all [F]iles (including hidden)' })
    map('n', '<leader>sS', live_grep_uu, { desc = '[s]earch [S]tring (grep all)' })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
    map('n', '<leader>s`', builtin.marks, { desc = '[`] Search marks' })
    map('n', '<leader>s/', grep_open_files, { desc = '[s]earch [/] string in open files' })
  end,
}
