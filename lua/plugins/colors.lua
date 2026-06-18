return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
	"nvim-tree/nvim-web-devicons", 
    },
    opts = {
	theme = 'rose-pine',
    },
  },
}
