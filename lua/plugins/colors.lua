local function pill(component, opts)
  return vim.tbl_extend("force", {
    component,
    separator = { left = "", right = "" },
    padding = { left = 1, right = 1 },
  }, opts or {})
end

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

        vim.api.nvim_set_hl(0, "Visual", { bg = "#5c5c5c" })

        -- Remove bracket background, keep foreground visible
        vim.api.nvim_set_hl(0, "MatchParen", {
          bg = "NONE",
          ctermbg = "NONE",
          fg = "#ffee93",
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
      options = {
        globalstatus = true,
        component_separators = " ",
        section_separators = "",
        theme = {
          normal = {
            a = { fg = "#191724", bg = "#8579a6", gui = "bold" },
            b = { fg = "#b0acbc", bg = "#26233a" },
            c = { fg = "#b0acbc", bg = "NONE" },
          },
          insert = {
            a = { fg = "#191724", bg = "#7cae7c", gui = "bold" },
            b = { fg = "#b0acbc", bg = "#26233a" },
            c = { fg = "#b0acbc", bg = "NONE" },
          },
          visual = {
            a = { fg = "#191724", bg = "#b59191", gui = "bold" },
            b = { fg = "#b0acbc", bg = "#26233a" },
            c = { fg = "#b0acbc", bg = "NONE" },
          },
          replace = {
            a = { fg = "#191724", bg = "#c97c7c", gui = "bold" },
            b = { fg = "#b0acbc", bg = "#26233a" },
            c = { fg = "#b0acbc", bg = "NONE" },
          },
          command = {
            a = { fg = "#191724", bg = "#a89780", gui = "bold" },
            b = { fg = "#b0acbc", bg = "#26233a" },
            c = { fg = "#b0acbc", bg = "NONE" },
          },
          inactive = {
            a = { fg = "#7a7686", bg = "NONE" },
            b = { fg = "#7a7686", bg = "NONE" },
            c = { fg = "#7a7686", bg = "NONE" },
          },
        },
      },
      sections = {
        lualine_a = {
          pill("mode"),
        },
        lualine_b = {
          pill("branch"),
          pill("diff"),
          pill("diagnostics"),
        },
        lualine_c = {
          pill("filename", { color = { fg = "#b0acbc", bg = "#26233a" } }),
        },
        lualine_x = {
          pill("encoding", { color = { fg = "#b0acbc", bg = "#26233a" } }),
          pill("fileformat", { color = { fg = "#b0acbc", bg = "#26233a" } }),
          pill("filetype", { color = { fg = "#b0acbc", bg = "#26233a" } }),
        },
        lualine_y = {
          pill("progress"),
        },
        lualine_z = {
          pill("location"),
        },
      },
    },
  },
}
