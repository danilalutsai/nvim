return {
  "folke/noice.nvim",
  event = "VeryLazy",

  dependencies = {
    "MunifTanjim/nui.nvim",

    {
      "rcarriga/nvim-notify",

      opts = {
        background_colour = "#191724",

        render = "compact",
        stages = "static",

        on_open = function(win)
          local buf = vim.api.nvim_win_get_buf(win)

          vim.bo[buf].filetype = ""
          vim.bo[buf].syntax = ""

          pcall(vim.treesitter.stop, buf)
        end,
      },

      config = function(_, opts)
        vim.opt.termguicolors = true

        vim.api.nvim_set_hl(0, "NotifyBackground", {
          bg = "#191724",
        })

        require("notify").setup(opts)
        vim.notify = require("notify")
      end,
    },
  },

  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
  },
}
