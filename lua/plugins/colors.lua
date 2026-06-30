return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      local variants = { "main", "moon", "dawn" }
      local current_variant = "moon"

      local opencode_palette = {
        base = "#232136",
        surface = "#2a273f",
        overlay = "#393552",
        text = "#e0def4",
        subtle = "#908caa",
        muted = "#6e6a86",
        love = "#eb6f92",
        gold = "#f6c177",
        rose = "#ea9a97",
        pine = "#3e8fb0",
        foam = "#9ccfd8",
        iris = "#c4a7e7",
      }

      local function rose_pine_opts()
        return {
          variant = current_variant,
          palette = {
            main = opencode_palette,
            moon = opencode_palette,
          },
          disable_background = true,
          disable_float_background = true,
          styles = {
            bold = true,
            italic = false,
            transparency = true,
          },
          highlight_groups = {
            StatusLine = { bg = "none" },
            StatusLineNC = { bg = "none" },
          },
        }
      end

      local palettes = {
        main = opencode_palette,
        moon = opencode_palette,
        dawn = {
          text = "#575279",
          muted = "#9893a5",
          surface = "#fffaf3",
          iris = "#907aa9",
          rose = "#d7827e",
        },
      }

      local function palette()
        return palettes[current_variant]
      end

      local function set_transparency()
        local colors = palette()
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

        vim.api.nvim_set_hl(0, "LineNr", { fg = colors.muted, bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.muted, bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.muted, bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.overlay })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.gold, bg = "NONE", bold = false })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#44415a" })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#44415a" })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = colors.text, bg = colors.surface })
        vim.api.nvim_set_hl(0, "TabLine", { fg = colors.gold, bg = "NONE" })
        vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.gold, bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Directory", { fg = "#c9c5e3", bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.iris, bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#c9c5e3", bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = colors.iris, bg = "NONE" })

        for _, group in ipairs({ "Comment", "@comment", "@comment.documentation", "@lsp.type.comment" }) do
          vim.api.nvim_set_hl(0, group, { fg = colors.muted, bg = "NONE", italic = false, bold = false })
        end

        vim.api.nvim_set_hl(0, "MatchParen", {
          bg = "NONE",
          ctermbg = "NONE",
          fg = colors.iris,
          bold = true,
          italic = false,
          underline = true,
        })
      end

      local function sync_tmux_theme()
        if not vim.env.TMUX then
          return
        end

        vim.fn.jobstart({ "sh", vim.fn.expand("~/.tmux-theme-toggle.sh"), current_variant }, { detach = true })
      end

      local function apply_variant(variant, notify)
        current_variant = variant
        vim.g.rose_pine_variant = current_variant
        require("rose-pine").setup(rose_pine_opts())
        vim.cmd.colorscheme(current_variant == "main" and "rose-pine" or "rose-pine-" .. current_variant)
        set_transparency()
        sync_tmux_theme()
        if notify then
          vim.notify("Rose Pine " .. current_variant, vim.log.levels.INFO)
        end
      end

      require("rose-pine").setup(rose_pine_opts())
      apply_variant(current_variant, false)

      vim.keymap.set("n", "<leader>cs", function()
        local index = vim.fn.index(variants, current_variant)
        apply_variant(variants[index % #variants + 1], true)
      end, { desc = "Cycle Rose Pine colorscheme" })

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter", "BufEnter" }, {
        callback = function()
          set_transparency()
        end,
      })
    end,
  },
}
