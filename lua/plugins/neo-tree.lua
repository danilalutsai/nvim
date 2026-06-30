local function hide_neo_tree_from_buffers()
  if vim.bo.filetype == "neo-tree" or vim.api.nvim_buf_get_name(0):match("neo%-tree") then
    vim.bo.buflisted = false
  end
end

local function set_neo_tree_highlights()
  vim.api.nvim_set_hl(0, "Directory", { fg = "#c9c5e3" })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#c9c5e3" })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NeoTreeFileStats", { fg = "#bac2de" })
  vim.api.nvim_set_hl(0, "NeoTreeFileStatsHeader", { fg = "#cdd6f4", bold = true })
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    config = function(_, opts)
      require("neo-tree").setup(opts)

      set_neo_tree_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_neo_tree_highlights,
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
        callback = hide_neo_tree_from_buffers,
      })
    end,
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle<CR>",
        desc = "Toggle Neo-tree",
      },
      {
        "<leader>E",
        function()
          local current_win = vim.api.nvim_get_current_win()
          local current_ft = vim.bo.filetype

          if current_ft == "neo-tree" then
            vim.cmd("wincmd p")
            return
          end

          vim.cmd("Neotree focus")

          if vim.api.nvim_get_current_win() == current_win then
            vim.cmd("Neotree show")
          end
        end,
        desc = "Focus Neo-tree",
      },
    },
    opts = {
      default_component_configs = {
        icon = {
          highlight = "NeoTreeFileIcon",
        },
        indent = {
          indent_size = 1,
          padding = 0,
          with_markers = false,
        },
        git_status = {
          symbols = {
            modified = "[+]",
            unstaged = "[+]",
            untracked = "[?]",
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      window = {
        position = "right",
        width = 40,
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
          ["r"] = "rename",
          ["v"] = "open_vsplit",
          ["V"] = "open_split",
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.bo.buflisted = false
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.statuscolumn = ""
          end,
        },
      },
    },
  },
}
