-- https://github.com/lukas-reineke/indent-blankline.nvim

  return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 500,
      indent = { char = "▏", smart_indent_cap = true },
      whitespace = { highlight = { "Whitespace", "NonText" } },
      exclude = {
        filetypes = {
          "help",
          "packer",
        },
        buftypes = { "terminal", "nofile" },
      }
    },
  }
