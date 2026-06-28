return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local flavours = { "latte", "frappe", "macchiato", "mocha" }
      local current_flavour = "frappe"

      local function catppuccin_opts(flavour)
        return {
          flavour = flavour,
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
        }
      end

      require("catppuccin").setup(catppuccin_opts(current_flavour))

      vim.cmd("colorscheme catppuccin")

      local function set_transparency()
        local palette = require("catppuccin.palettes").get_palette(current_flavour)
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
        }

        for _, group in ipairs(transparent_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE" })
        end

        vim.api.nvim_set_hl(0, "LineNr", { fg = palette.overlay1, bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = palette.overlay0, bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = palette.overlay0, bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.surface0 })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.peach, bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = palette.text, bg = palette.surface0 })

        vim.api.nvim_set_hl(0, "MatchParen", {
          bg = "NONE",
          ctermbg = "NONE",
          fg = palette.peach,
          bold = false,
          underline = false,
        })
      end

      local function apply_flavour(flavour)
        current_flavour = flavour
        require("catppuccin").setup(catppuccin_opts(current_flavour))
        vim.cmd("colorscheme catppuccin")
        set_transparency()
        vim.notify("Catppuccin " .. current_flavour, vim.log.levels.INFO)
      end

      vim.keymap.set("n", "<leader>cs", function()
        local index = vim.tbl_contains(flavours, current_flavour) and vim.fn.index(flavours, current_flavour) + 1 or 1
        apply_flavour(flavours[index % #flavours + 1])
      end, { desc = "Cycle Catppuccin colorscheme" })

      set_transparency()

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter", "BufEnter" }, {
        callback = function()
          set_transparency()
        end,
      })
    end,
  },
}
