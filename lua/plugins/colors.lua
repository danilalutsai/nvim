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
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "NormalFloat",
          "FloatBorder",
          "SignColumn",
          "EndOfBuffer",

          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptNormal",
          "TelescopePromptBorder",
          "TelescopePromptTitle",
          "TelescopeResultsNormal",
          "TelescopeResultsTitle",
          "TelescopePreviewNormal",
          "TelescopePreviewTitle",
          "TelescopeSelection",
        }

        for _, group in ipairs(transparent_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE" })
        end

        vim.api.nvim_set_hl(0, "Visual", { bg = "#5c5c5c" })

        -- Remove bracket background, keep foreground visible
        vim.api.nvim_set_hl(0, "MatchParen", {
          bg = "NONE",
          ctermbg = "NONE",
          fg = "#b0acbc",
          bold = false,
          underline = false,
        })
      end

      set_transparency()

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter", "BufEnter" }, {
        callback = function()
          set_transparency()
        end,
      })

      local variants = {
        "rose-pine-main",
        "rose-pine-moon",
        "rose-pine-dawn",
      }

      local current = 1

      vim.keymap.set("n", "<leader>cs", function()
        current = (current % #variants) + 1
        vim.cmd("colorscheme " .. variants[current])
        set_transparency()
        print("Colorscheme: " .. variants[current])
      end, {
        desc = "Cycle rose-pine variants",
        noremap = true,
        silent = true,
      })
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
