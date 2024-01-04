-- https://github.com/lukas-reineke/indent-blankline.nvim

  return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 500,
      indent = { char = "▏", smart_indent_cap = true },
      -- enabled
      --   enabled
      -- enabled
      whitespace = { highlight = { "Whitespace", "NonText" } },
      exclude = {
        -- language = { "lua" } ,
        filetypes = {
          "help",
          "packer",
          "NvimTree",
        },
        buftypes = { "terminal", "nofile" },
      }
    },
  }
