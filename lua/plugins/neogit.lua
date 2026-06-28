return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local function set_neogit_cursorline()
        local palette = require("catppuccin.palettes").get_palette()
        vim.api.nvim_set_hl(0, "NeogitCursorLine", { bg = palette.surface0 })
        vim.api.nvim_set_hl(0, "NeogitCursorLineNr", { fg = palette.peach, bg = "NONE", bold = true })
      end

      local function enable_neogit_cursorline()
        if not vim.bo.filetype:lower():match("^neogit") then
          return
        end

        vim.opt_local.cursorline = true
        vim.opt_local.cursorlineopt = "both"

        local winhighlight = vim.wo.winhighlight
        if not winhighlight:find("CursorLine:NeogitCursorLine", 1, true) then
          vim.wo.winhighlight = table.concat({
            winhighlight,
            "CursorLine:NeogitCursorLine",
            "CursorLineNr:NeogitCursorLineNr",
          }, ","):gsub("^,", "")
        end
      end

      require("neogit").setup({
        integrations = {
          diffview = true,
          telescope = true,
        },
        mappings = {
          commit_editor = {
            ["C"] = "Submit",
            ["<c-c><c-c>"] = false,
          },
          commit_editor_I = {
            ["<c-c><c-c>"] = false,
          },
        },
      })

      set_neogit_cursorline()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_neogit_cursorline,
      })

      vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
        callback = function()
          vim.schedule(enable_neogit_cursorline)
        end,
      })
    end,
  },
}
