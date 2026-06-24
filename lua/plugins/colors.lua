return {
  {
    "rose-pine/neovim",
    name = "rose-pine",

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
            pine = "#476991",
            foam = "#6e9eb0",
            iris = "#8579a6",
            leaf = "#7cae7c",
          },
        },
        disable_background = true,
      })

      vim.cmd("colorscheme rose-pine-main")

      local function set_transparency()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#403f52" })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#5c5c5c" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "NONE" })
      end

      set_transparency()

      -- cycle through rose-pine variants
      local variants = { "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" }
      local current = 1

      vim.keymap.set("n", "<leader>cs", function()
        current = (current % #variants) + 1
        vim.cmd("colorscheme " .. variants[current])
        set_transparency()
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
