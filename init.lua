--[[ OPTIONS START ]]
-- TODO REMOVE UNUSED
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.conceallevel = 0
vim.opt.fileencoding = 'utf-8'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
-- vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.fillchars.eob = ' '
vim.opt.linebreak = true
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.guifont = 'Iosevka:h28'

--[[ OPTIONS END ]]

--[[ AUTOCOMMANDS START ]]
--TODO figure out when these are usefull
local autocmd = vim.api.nvim_create_autocmd
autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel' },
  callback = function()
    vim.cmd [[ nnoremap <silent> <buffer> q :close<CR> set nobuflisted
    ]]
  end,
})

autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd({ 'VimResized' }, {
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

autocmd({ 'CmdWinEnter' }, {
  callback = function()
    vim.cmd 'quit'
  end,
})

autocmd({ 'TextYankPost' }, {
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
  end,
})

autocmd({ 'BufWritePost' }, {
  pattern = { '*.java' },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

autocmd({ 'VimEnter' }, {
  callback = function()
    vim.cmd 'hi link illuminatedWord LspReferenceText'
  end,
})

autocmd({ 'BufWinEnter' }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd 'IlluminatePauseBuf'
    end
  end,
})
--[[ AUTOCOMMANDS END ]]

--[[ KEYMAPS START ]]

-- MODES --
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   all = "",

-- KEYMAP LOCALS --
local key = vim.keymap.set
local key_opts = function(desc, event)
  local opts = { silent = false, desc = desc or '**No Description**' }
  if event then
    -- Event used only for LSP
    opts.buffer = event.buf
  end
  return opts
end

-- BINDINGS --
-- Disable Single Space
key('', '<Space>', '<Nop>', key_opts 'Space')

-- Center cursor when moving pages
key('n', '<C-d>', '<C-d>zz')
key('n', '<C-u>', '<C-u>zz')
key('n', '<C-f>', '<C-f>zz')
key('n', '<C-b>', '<C-b>zz')

-- Better window navigation
key('n', '<C-h>', '<C-w>h', key_opts 'Window Navigate Left')
key('n', '<C-j>', '<C-w>j', key_opts 'Window Navigate Down')
key('n', '<C-k>', '<C-w>k', key_opts 'Window Navigate Up')
key('n', '<C-l>', '<C-w>l', key_opts 'Window Navigate Right')

-- Resize with Alt-hjkl
key('n', '˚', ':resize -2<CR>', key_opts 'Window Horizontal Shrink')
key('n', '∆', ':resize +2<CR>', key_opts 'Window Horizontal Grow')
key('n', '˙', ':vertical resize -2<CR>', key_opts 'Window Vertical Shrink')
key('n', '¬', ':vertical resize +2<CR>', key_opts 'Window Vertical Grow')
key('n', '≠', '<C-w>=', key_opts 'Equalize Windows')

--Tabs
key('n', '<leader>tn', ':tabnew<CR>', key_opts 'Tab New')
key('n', '<leader>tc', ':tabclose<CR>', key_opts 'Tab Close')
key('n', '<leader>to', ':tabonly<CR>', key_opts 'Tab Only')

-- Navigate buffers
key('n', '<C-n>', ':bnext<CR>', key_opts 'Buffer Next')
key('n', '<C-p>', ':bprevious<CR>', key_opts 'Buffer Previous')
key('n', '<C-6>', '<C-^>', key_opts 'Alternate Buffer')
key('n', '<leader>bn', ':bnext<CR>', key_opts 'Buffer Next')
key('n', '<leader>bp', ':bprevious<CR>', key_opts 'Buffer Previous')
key('n', '<leader>ba', '<C-^>', key_opts 'Alternate Buffer')

--Save buffers
key({ 'n', 'v' }, '<leader>bs', ':write<CR>', key_opts 'Write Buffer')
key({ 'n', 'v' }, 'ZS', ':write<CR>', key_opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bS', ':wall<CR>', key_opts 'Write all Buffers')
key({ 'n', 'v' }, '<leader>bw', ':write<CR>', key_opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bW', ':wall<CR>', key_opts 'Write all Buffers')
key({ 'n', 'v' }, '<C-s>', ':write<CR>', key_opts 'Write Buffer')
key({ 'n', 'v' }, '<C-S>', ':wall<CR>', key_opts 'Write all Buffers')

-- Close buffers
-- TODO SIMPLIFY THIS USING THE Z command
-- switch to prev buffer then delete prev buffer [ bdelete# ]
-- That way splits dont close
-- TODO Organize these And figure out what they do
key('n', '<leader>bd', ':bprevious<bar>bdelete#!<CR>', key_opts 'Delete Buffer (Discard Changes)')
key('n', '<leader>bD', ':bprevious<bar> %bdelete!<CR>', key_opts 'Delete All Buffer (Discard Changes)')
key('n', '<leader>bc', ':write<bar>bprevious<bar>bdelete#<CR>', key_opts 'Write & Delete Buffer')
key('n', '<leader>bC', ':wall<bar> %bdelete<CR>', key_opts 'Write & Delete Buffers')
key('n', '<leader>bqq<CR>', ':qa!<CR>', key_opts 'Quit All Buffers')

-- Clear highlights
key('n', '<leader>x', ':nohlsearch<cr>', key_opts 'clear search highlight')

-- Paste in visual mode doesn't polute the clipboard with the old selection
key('v', 'p', '"_dp', key_opts())

-- press jk fast to esc
key('i', 'kj', '<esc>', key_opts())

-- visual stay in indent mode
key('v', '<', '<gv', key_opts())
key('v', '>', '>gv', key_opts())

-- Netrw
key('n', '<leader>o-', vim.cmd.Lex, key_opts 'Open Netrw')

-- Move line in visual mode
key('v', 'J', ":m '>+1<CR>gv=gv")
key('v', 'K', ":m '<-2<CR>gv=gv")

--Insert New Line in normal mode
key('n', '[o', 'moO<ESC>`o', key_opts 'Empty Line above')
key('n', ']o', 'moo<ESC>`o', key_opts 'Empty Line below')

-- Split Line
key('n', '|', 'i<CR><Esc>', key_opts 'Split line (Opposite of J)')

-- Sessions
key('n', '<leader>qs', ':mksession!<CR>', key_opts 'Make session')
key('n', '<leader>ql', ':source Session.vim<CR>', key_opts 'Make load')

-- Diagnostics
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
key('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', key_opts 'Open Diagnostic f[l]oat')
key('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', key_opts 'Go to previous [d]iagnostic')
key('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', key_opts 'Go to next [d]iagnostic')
--[[ KEYMAPS END ]]

-- [[ LAZY BOOTSTRAP START ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
-- [[ LAZY BOOTSTRAP END ]]

-- [[ LSP SETTINGS START ]]
-- Setting up bindings variables and other settings
-- these will be used when setting up the lsp plugins

-- CONFIG DIAGNOSTICS & HOVER --

-- LSP Hover Setup
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  title = 'LSP Hover', -- add the title in hover float window
})

-- LSP Diagnostics Setup
vim.diagnostic.config {
  signs = true, -- Diagnostic signs on the nr column
  underline = true, -- Underline the error
  virtual_text = true, -- Inline message
  update_in_insert = true, -- Real time update of virtual text in INSERT mode
  float = {
    title = 'Vim Diagnostic', -- add the title in hover float window
    border = 'rounded',
    focusable = true, -- Focus on the diagnostic with <C-w>w
  },
}

-- FUNCTIONS --

-- LSP Format
-- This function is called when formatting the file using the LSP
local lspFormat = function()
  vim.lsp.buf.format {
    filter = function(client)
      -- Filter out the tsserver for formating
      -- This lets null-ls take over for the formating
      return client.name ~= 'tsserver'
    end,
    async = false,
    timeout_ms = 10000,
  }
end

-- CMP Super tab functions --

-- Check Backspace
local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end
-- Tab
local cmp_tab = function(cmp, luasnip)
  return function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
    else
      fallback()
    end
  end
end

-- Shift-Tab
local cmp_shift_tab = function(cmp, luasnip)
  return function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end
end

-- LSP AUTOCOMMANDS --
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local lsp_key_opts = function(desc)
      return key_opts(desc, event)
    end
    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    key('n', 'K', vim.lsp.buf.hover, lsp_key_opts '[K] Hover info')
    key('n', '<leader>cK', vim.lsp.buf.hover, lsp_key_opts '[K] Hover info')
    key('n', '<leader>cgg', vim.lsp.buf.signature_help, lsp_key_opts 'Si[g]nature help (alias: <C-g>)')
    key('n', '<C-g>', vim.lsp.buf.signature_help, lsp_key_opts 'Si[g]nature help')
    key('n', '<leader>cgd', vim.lsp.buf.definition, lsp_key_opts '[d]efinition')
    key('n', 'gd', vim.lsp.buf.definition, lsp_key_opts '[d]efinition')
    key('n', '<leader>cgl', vim.diagnostic.open_float, lsp_key_opts 'Diagnostics in F[l]oating window')
    key('n', '<leader>cgD', vim.lsp.buf.declaration, lsp_key_opts '[D]eclaration')
    key('n', '<leader>cgi', vim.lsp.buf.implementation, lsp_key_opts '[i]mplementation')
    key('n', '<leader>cgo', vim.lsp.buf.type_definition, lsp_key_opts 'Symb[o]l type definition')
    key('n', '<leader>cgr', require('telescope.builtin').lsp_references, lsp_key_opts '[r]eferences')
    key('n', 'gr', require('telescope.builtin').lsp_references, lsp_key_opts 'Go to [r]eferences')
    key('n', '<leader>c[d', vim.diagnostic.goto_prev, lsp_key_opts 'Previous Diagnostic')
    key('n', '<leader>c]d ', vim.diagnostic.goto_next, lsp_key_opts 'Next Diagnostic')
    key('n', '<leader>cr', vim.lsp.buf.rename, lsp_key_opts '[R]ename')
    key('n', '<leader>ca', vim.lsp.buf.code_action, lsp_key_opts '[A]ction')
    key('n', '<leader>cf', lspFormat, lsp_key_opts '[f]ormat')
    -- more keybindings...
    key('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, lsp_key_opts '[S]ymbols')
    key('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, lsp_key_opts '[a]dd Folder')
    key('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, lsp_key_opts '[r]emove Folder')
    key('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, lsp_key_opts '[l]ist folder')
  end,
})

-- ICONS --
local cmp_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

-- [[ LSP SETTINGS END ]]

--[[ PLUGINS SETUP START ]]

-- NOTES
-- opts = {} is the equivalent of the setup({}) function
require('lazy').setup {
  { -- TREESITTER --
    { -- Treesitter --
      -- TODO Leard what setting are usefull below and remove what is not needed
      -- https://github.com/nvim-treesitter/nvim-treesitter
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require 'nvim-treesitter.configs'
        configs.setup {
          ensure_installed = { 'lua', 'markdown', 'markdown_inline', 'bash', 'python', 'javascript', 'typescript', 'html', 'css', 'scss' }, -- put the language you want in this array
          ignore_install = { '' }, -- List of parsers to ignore installing
          sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
          highlight = {
            enable = true, -- false will disable the whole extension
            -- disable = { "css" }, -- list of language that will be disabled
          },
          autopairs = {
            enable = true,
          },
          indent = { enable = true, disable = { 'python' } },

          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<C-space>',
              node_incremental = '<C-space>',
              -- scope_incremental = '<C-s>',
              node_decremental = '<C-backspace>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end,
    },
    {
      -- Treesitter Context --
      -- Show function context at top of the screen when function is long
      -- https://github.com/nvim-treesitter/nvim-treesitter-context
      'nvim-treesitter/nvim-treesitter-context',
      opts = {},
      config = function()
        -- Adds underline to context regardless of the colorscheme
        vim.cmd 'hi TreesitterContextBottom gui=underline guisp=Grey'
        key('n', '<leader>cc', ':TSContextToggle<CR>', key_opts 'TS [c]ontext toggle')
      end,
    },
  },
  { -- COLORSCHEMES --
    'cpea2506/one_monokai.nvim',
    dependencies = {
      'navarasu/onedark.nvim',
      'folke/tokyonight.nvim',
      'catppuccin/nvim',
      'Mofiqul/dracula.nvim',
      'romgrk/doom-one.vim',
      'bluz71/vim-moonfly-colors',
    },
    config = function()
      vim.cmd 'colorscheme one_monokai'
    end,
  },
  { -- WELCOME SCREEN --
    -- Adds a start up screen instead of empty buffer
    -- https://github.com/goolord/alpha-nvim
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },
  { -- STATUS LINE --
    -- https://github.com/nvim-lualine/lualine.nvim
    -- TODO Try removing the options
    'nvim-lualine/lualine.nvim',
    config = function()
      local hide = function(section, width)
        width = width or 150
        local condition = function()
          return vim.fn.winwidth(0) > width
        end
        return { section, cond = condition }
      end
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'alpha', 'dashboard', 'packer', 'NVimTree' },
          disabled_buftypes = { 'quickfix', 'prompt' },
          ignore_focus = {},
          always_divide_middle = false,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'filename', path = 1 } },
          lualine_c = { hide 'diff', hide 'diagnostics' },
          lualine_x = { hide('branch', 100), hide 'encoding', hide 'fileformat', hide 'filetype' },
          lualine_y = { hide 'progress' },
          lualine_z = { hide 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree', 'neo-tree' },
      }
    end,
  },
  { -- FILE TREE --
    -- TODO Try removing the options
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
      },
    },
    config = function()
      vim.cmd [[nnoremap <leader>e :Neotree left toggle<cr>]]
      vim.cmd [[nnoremap <leader>E :Neotree float toggle<cr>]]
      require('neo-tree').setup {
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function()
              vim.cmd [[
          setlocal relativenumber
          ]]
            end,
          },
        },
      }
    end,
    opts = {
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = false,
      -- used when sorting files and directories in the tree
      sort_function = nil, -- use a custom function for sorting files and directories in the tree
      -- sort_function = function (a,b)
      --       if a.type == b.type then
      --           return a.path > b.path
      --       else
      --           return a.type > b.type
      --       end
      --   end , -- this sorts files and directories descendantly
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = 'ﰊ',
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '✖', -- this can only be used in the git_status source
            renamed = '', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
      },
      window = {
        position = 'left',
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['<space>'] = {
            'toggle_node',
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'revert_preview',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          -- ["S"] = "split_with_window_picker",
          -- ["s"] = "vsplit_with_window_picker",
          ['t'] = 'open_tabnew',
          -- ["<cr>"] = "open_drop",
          -- ["t"] = "open_tab_drop",
          ['w'] = 'open_with_window_picker',
          --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
          ['C'] = 'close_node',
          -- ['C'] = 'close_all_subnodes',
          ['z'] = 'close_all_nodes',
          --["Z"] = "expand_all_nodes",
          ['a'] = {
            'add',
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = 'none', -- "none", "relative", "absolute"
            },
          },
          ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
          -- ["c"] = {
          --  "copy",
          --  config = {
          --    show_path = "none" -- "none", "relative", "absolute"
          --  }
          --}
          ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = { enabled = false }, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['D'] = 'fuzzy_finder_directory',
            ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ['f'] = 'filter_on_submit',
            ['<c-x>'] = 'clear_filter',
            ['[g'] = 'prev_git_modified',
            [']g'] = 'next_git_modified',
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
          },
        },
      },
      git_status = {
        window = {
          position = 'float',
          mappings = {
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
          },
        },
      },
    },
  },
  { -- TMUX NAVIGATION --
    -- https://github.com/aserowy/tmux.nvim
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
  },
  { -- TOGGLE TERM --
    -- TODO See what options can be removed
    -- https://github.com/akinsho/toggleterm.nvim
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = 'curved' },
    },
  },
  {
    -- UNDO TREE
    -- https://github.com/jiaoshijie/undotree
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  { -- WHICH KEY --
    -- https://github.com/folke/which-key.nvim
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local whichkey = require 'which-key'
      whichkey.register {
        ['<leader>b'] = { name = 'Buffer' },
        ['<leader>c'] = { name = '[C]ode (LSP)' },
        ['<leader>g'] = { name = '[G]it' },
        ['<leader>w'] = { name = '[W]orkspace' },
        ['<leader>s'] = { name = '[S]earch' },
      }
    end,
  },
  { -- TELESCOPE --
    -- https://github.com/nvim-telescope/telescope.nvim
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },

    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        defaults = {
          path_display = { 'smart' },
          -- file_ignore_patterns = { '.git/', 'node_modules' },
          mappings = {
            -- TODO See defaults and maybe remove these
            i = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-d>'] = actions.delete_buffer,
            },
            n = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-d>'] = actions.delete_buffer,
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')

      key('n', '<leader>?', builtin.oldfiles, key_opts '[?] Find recently opened files')
      key('n', '<leader><space>', builtin.buffers, key_opts '[ ] Find existing buffers')
      key('n', '<leader>/', builtin.current_buffer_fuzzy_find, key_opts '[/] Fuzzily search in current buffer]')
      key('n', '<leader>sf', builtin.find_files, key_opts '[S]earch [f]iles')
      key('n', '<leader>sF', builtin.git_files, key_opts '[S]earch Git [F]iles')
      key('n', '<leader>sh', builtin.help_tags, key_opts '[S]earch [H]elp')
      key('n', '<leader>sW', builtin.grep_string, key_opts '[S]earch current [W]ord')
      key('n', '<leader>sw', builtin.live_grep, key_opts '[S]earch [w]ord by Grep')
      key('n', '<leader>ss', builtin.live_grep, key_opts '[S]earch by [G]rep')
      key('n', '<leader>sd', builtin.diagnostics, key_opts '[S]earch [D]iagnostics')
      key('n', '<leader>sk', builtin.keymaps, key_opts '[S]earch [K]eymaps')
      key('n', '<leader>sc', builtin.colorscheme, key_opts '[S]earch [c]olorschemes')
    end,
  },
  { -- (( OTHER )) --
    { -- Vim-sleuth --
      -- TODO Se if it's usefull and remove if not
      -- Detect tabstop and shiftwidth automatically
      -- Setting up indent levels and styles (based on existing files)
      -- https://github.com/tpope/vim-sleuth
      'tpope/vim-sleuth',
    },
    { -- Highlight Word --
      -- https://github.com/RRethy/vim-illuminate
      -- Vim plugin for automatically highlighting other uses of
      -- the word under the cursor using either LSP, Tree-sitter, or regex matching.
      'RRethy/vim-illuminate',
    },
    { -- (( INDENT GUIDE-LINE )) --
      -- TODO -- Try removing it or removing opts
      -- https://github.com/lukas-reineke/indent-blankline.nvim
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl',
      opts = {
        debounce = 500,
        indent = { char = '▏', smart_indent_cap = true },
        whitespace = { highlight = { 'Whitespace', 'NonText' } },
        exclude = {
          filetypes = {
            'help',
            'packer',
          },
          buftypes = { 'terminal', 'nofile' },
        },
      },
    },
  },
  { -- (( MOTIONS )) --
    { -- Surround Motion
      -- https://github.com/kylechui/nvim-surround
      'kylechui/nvim-surround',
      version = '*', -- Use for stability; omit to use `main` branch for the latest features
      event = 'VeryLazy',
      opts = {},
    },
    { -- Commment Motions
      -- https://github.com/numToStr/Comment.nvim
      'numToStr/Comment.nvim',
      dependencies = {
        -- Commend based on treesitter context ( used for JSX )
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      opts = {
      --  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      },
       -- TODO Delete this if it works with opts = {}
       config = function()
         require('Comment').setup {
           pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
         }
       end,
    },
  },
  { -- (( HARPOON )) --
    -- Cool bookmark  file navigation
    'ThePrimeagen/harpoon',
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'
      local nav = function(file_nr)
        return function()
          ui.nav_file(file_nr)
        end
      end
      key('n', '<leader>m', mark.add_file, key_opts 'Harpoon [m]ark')
      key('n', '<leader>M', ui.toggle_quick_menu, key_opts 'Harpoon [M]enu')
      key('n', '<leader>n', ui.nav_next, key_opts 'Harpoon [n]ext')
      key('n', '<leader>p', ui.nav_prev, key_opts 'Harpoon [p]revious')
      key('n', '<leader>h', nav(1), key_opts 'Harpoon to file 1')
      key('n', '<leader>j', nav(2), key_opts 'Harpoon to file 2')
      key('n', '<leader>k', nav(3), key_opts 'Harpoon to file 3')
      key('n', '<leader>l', nav(4), key_opts 'Harpoon to file 4')
      key('n', '<leader>;', nav(5), key_opts 'Harpoon to file 5')
      key('n', "<leader>'", nav(6), key_opts 'Harpoon to file 6')
    end,
  },
  { -- (( AUTO CLOSE BRACKETS & TAGS )) --
    { -- Auto-pairs --
      -- https://github.com/windwp/nvim-autopairs
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {},
    },
    { -- Auto-tag --
      -- NOTE Might not work due to treesitter
      -- https://github.com/windwp/nvim-ts-autotag
      'windwp/nvim-ts-autotag',
      event = 'InsertEnter',
      opts = {},
    },
  },
  { -- (( GIT )) --
    -- TODO Learn to use these or remove them
    { -- GIT COMMANDS --
      -- https://github.com/tpope/vim-fugitive
      'tpope/vim-fugitive',
    },
    { -- GITHUB INTEGRATION
      -- https://github.com/tpope/vim-rhubarb
      'tpope/vim-rhubarb',
    },
    { -- GIT SIGNS & ACTIONS
      -- https://github.com/lewis6991/gitsigns.nvim
      'lewis6991/gitsigns.nvim',
      opts = {
        -- TODO Remove these if the defaults are acceptable
        -- signs = {
        --   add = { text = '+' },
        --   change = { text = '~' },
        --   delete = { text = '_' },
        --   topdelete = { text = '‾' },
        --   changedelete = { text = '~' },
        -- },
        on_attach = function(bufnr)
          -- Gitsigns Locals --
          local git_signs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, gitsigns_opts)
            gitsigns_opts = gitsigns_opts or {}
            gitsigns_opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, gitsigns_opts)
          end

          -- Gitsigns keymaps --
          -- Navigation
          map({ 'n', 'v' }, ']h', function()
            if vim.wo.diff then
              return ']h'
            end
            vim.schedule(git_signs.next_hunk)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to next hunk' })

          map({ 'n', 'v' }, '[h', function()
            if vim.wo.diff then
              return '[h'
            end
            vim.schedule(git_signs.prev_hunk)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to previous hunk' })

          -- Actions
          -- -- visual mode
          map('v', '<leader>gs', function()
            git_signs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'stage git hunk' })
          map('v', '<leader>gr', function()
            git_signs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'reset git hunk' })
          -- -- normal mode
          map('n', '<leader>gs', git_signs.stage_hunk, { desc = 'git stage hunk' })
          map('n', '<leader>gr', git_signs.reset_hunk, { desc = 'git reset hunk' })
          map('n', '<leader>gS', git_signs.stage_buffer, { desc = 'git Stage buffer' })
          map('n', '<leader>gR', git_signs.reset_buffer, { desc = 'git Reset buffer' })
          map('n', '<leader>gu', git_signs.undo_stage_hunk, { desc = 'undo stage hunk' })
          map('n', '<leader>gp', git_signs.preview_hunk, { desc = 'preview git hunk' })
          map('n', '<leader>gB', git_signs.blame_line, { desc = 'git blame line' })
          map('n', '<leader>gd', git_signs.diffthis, { desc = 'git diff against index' })
          map('n', '<leader>gD', function()
            git_signs.diffthis '~'
          end, { desc = 'git diff against last commit' })
          -- -- toggles
          map('n', '<leader>gb', git_signs.toggle_current_line_blame, { desc = 'toggle git blame line' })
          map('n', '<leader>gd', git_signs.toggle_deleted, { desc = 'toggle git show deleted' })
        end,
      },
    },
    { -- LAZYGIT
      -- https://github.com/kdheepak/lazygit.nvim
      'kdheepak/lazygit.nvim',
      dependencies = {
        -- optional for floating window border decoration
        -- TODO Try without plenary
        'nvim-lua/plenary.nvim',
      },
      config = function()
        key('n', '<leader>gg', '<cmd>LazyGit<CR>', key_opts 'Lazy [G]it')
      end,
    },
  },

  {
    -- LSP SETUP --
    {
      -- NEODEV --
      -- Automatically configures lua-language-server for your
      -- Neovim config, Neovim runtime and plugin directories
      -- https://github.com/folke/neodev.nvim
      'folke/neodev.nvim',
      opts = {},
    },
    { -- LSP NOTIFICATIONS --
      -- https://github.com/j-hui/fidget.nvim
      'j-hui/fidget.nvim',
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'L3MON4D3/LuaSnip',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer', -- Optional
        'hrsh7th/cmp-path', -- Optional
        'saadparwaiz1/cmp_luasnip', -- Optional
        'hrsh7th/cmp-nvim-lua', -- Optional
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'rafamadriz/friendly-snippets',
        'j-hui/fidget.nvim', -- Optional
        'nvimtools/none-ls.nvim',
        'jay-babu/mason-null-ls.nvim',
      },
      config = function()
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        local default_setup = function(server)
          require('lspconfig')[server].setup {
            capabilities = lsp_capabilities,
          }
        end

        require('mason').setup {}
        require('mason-lspconfig').setup {
          ensure_installed = { 'eslint', 'tsserver' },
          handlers = { default_setup },
        }

        require('null-ls').setup {}
        require('mason-null-ls').setup {
          ensure_installed = { 'prettier', 'eslint' },
          automatic_installation = true,
          handlers = {},
        }

        local luasnip = require 'luasnip'
        require('luasnip/loaders/from_vscode').lazy_load()
        local cmp = require 'cmp'
        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping {
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
            },
            -- Accept currently selected item. If none selected, `select` first item.
            --     -- Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm { select = true },
            ['<Tab>'] = cmp.mapping(cmp_tab(cmp, luasnip), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp_shift_tab(cmp, luasnip), { 'i', 's' }),
          },
          formatting = {
            expandable_indicator = true,
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
              vim_item.kind = cmp_icons[vim_item.kind]
              vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[nvim_lua]',
                buffer = '[buffer]',
                path = '[path]',
                nvim_lsp_signature_help = '[LSP-Signature]',
              })[entry.source.name]
              return vim_item
            end,
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
          },
          select_behavior = 'insert',
          experimental = {
            ghost_text = false,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
        }
      end,
    },
  },
}

--[[ PLUGINS SETUP END ]]
--
