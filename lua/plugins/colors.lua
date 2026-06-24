return {
  {
    "rose-pine/neovim",
    name = "rose-pine",

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" }),
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }),


    lazy = false,
    priority = 1000,
    config = function()

      require("rose-pine").setup({
        disable_italics = true,
        variant = "auto",
        dark_variant = "main",
        palette = {
          main = {
            text = "#b0acbc",
            subtle = "#7a7686",
            muted = "#5e5a6e",
            love = "#c97c7c",
            gold = "#a89780",
            rose = "#b59191",
            pine = "#3e5a7c",
            foam = "#6e9eb0",
            iris = "#8579a6",
            leaf = "#7cae7c",
          },
        },
        highlight_groups = {
          Normal = { bg = "none" },
          NormalFloat = { bg = "none" },
        },
      })

      vim.cmd("colorscheme rose-pine-main")

      -- cycle through rose-pine variants
      local variants = { "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" }
      local current = 1

      vim.keymap.set("n", "<leader>cs", function()
        current = (current % #variants) + 1
        vim.cmd("colorscheme " .. variants[current])
        print("Colorscheme: " .. variants[current])
      end, { desc = "Cycle rose-pine variants", noremap = true, silent = true })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "rose-pine",
      options = {
        globalstatus = true,
      },
    },
  },
}
