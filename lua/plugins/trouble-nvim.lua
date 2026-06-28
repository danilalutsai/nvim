return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>cS",
        "<cmd>Trouble symbols toggle focus=false<CR>",
        desc = "Symbols",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / References",
      },
    },
  },
}
