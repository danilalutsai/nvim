return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        no_italic = true,
        styles = {
          booleans = { "bold" },
          conditionals = { "bold" },
          functions = { "bold" },
          keywords = { "bold" },
          loops = { "bold" },
          types = { "bold" },
        },
      })

      vim.cmd("colorscheme catppuccin")

      local function set_transparency()
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "NormalFloat",
          "FloatBorder",
          "SignColumn",
          "EndOfBuffer",
          "StatusLine",
          "StatusLineNC",

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

        vim.api.nvim_set_hl(0, "LineNr", { fg = "#7f849c", bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6c7086", bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6c7086", bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fab387", bg = "NONE", bold = true })

        vim.api.nvim_set_hl(0, "MatchParen", {
          bg = "NONE",
          ctermbg = "NONE",
          fg = "#fab387",
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
    end,
  },
}
