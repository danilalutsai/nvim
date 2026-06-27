return {
  "rcarriga/nvim-notify",

  lazy = false,
  priority = 1000,

  init = function()
    vim.opt.termguicolors = true

    vim.notify = require("notify")

    require("notify").setup({
      background_colour = "#191724",

      render = "compact",
      stages = "static",

      on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)

        vim.bo[buf].filetype = ""
        vim.bo[buf].syntax = ""

        pcall(vim.treesitter.stop, buf)
      end,
    })
  end,
}
