local function block(component, opts)
  return vim.tbl_extend("force", {
    component,
    separator = "",
    padding = { left = 1, right = 1 },
  }, opts or {})
end

local bg = "#313244"
local bar_bg = "#313244"
local fg = "#cdd6f4"
local filetype_fg = "#1e1e2e"

local function filetype_with_icon()
  local filetype = vim.bo.filetype

  if filetype == "" then
    return ""
  end

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return filetype
  end

  local icon = devicons.get_icon_by_filetype(filetype, { default = true })

  return icon .. " " .. filetype
end

return {
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
            a = { fg = "#1e1e2e", bg = "#cba6f7", gui = "bold" },
            b = { fg = fg, bg = bar_bg },
            c = { fg = fg, bg = bar_bg },
          },
          insert = {
            a = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" },
            b = { fg = fg, bg = bar_bg },
            c = { fg = fg, bg = bar_bg },
          },
          visual = {
            a = { fg = "#1e1e2e", bg = "#fab387", gui = "bold" },
            b = { fg = fg, bg = bar_bg },
            c = { fg = fg, bg = bar_bg },
          },
          replace = {
            a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
            b = { fg = fg, bg = bar_bg },
            c = { fg = fg, bg = bar_bg },
          },
          command = {
            a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
            b = { fg = fg, bg = bar_bg },
            c = { fg = fg, bg = bar_bg },
          },
          inactive = {
            a = { fg = "#6c7086", bg = bar_bg },
            b = { fg = "#6c7086", bg = bar_bg },
            c = { fg = "#6c7086", bg = bar_bg },
          },
        },
      },
      sections = {
        lualine_a = {
          block("mode"),
        },
        lualine_b = {
          block("diagnostics", { color = { fg = fg, bg = bg } }),
        },
        lualine_c = {
          block("buffers", {
            mode = 2,
            buffers_color = {
              active = { fg = "#1e1e2e", bg = "#fab387", gui = "bold" },
              inactive = { fg = fg, bg = bg },
            },
          }),
        },
        lualine_x = {
          block("encoding", { color = { fg = fg, bg = bg } }),
          block("fileformat", { color = { fg = fg, bg = bg } }),
          block("searchcount", { color = { fg = fg, bg = bg } }),
          block("filesize", { color = { fg = fg, bg = bg } }),
          block("branch", { color = { fg = fg, bg = bg } }),
          block("diff", { color = { fg = fg, bg = bg } }),
          block("selectioncount", { color = { fg = fg, bg = bg } }),
          block("diagnostics", { color = { fg = fg, bg = bg } }),
          block(filetype_with_icon, { color = { fg = filetype_fg, bg = "#89b4fa", gui = "bold" } }),
        },
        lualine_y = {
          block("progress", { color = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" } }),
        },
        lualine_z = {
          block("location", { color = { fg = "#1e1e2e", bg = "#cba6f7", gui = "bold" } }),
        },
      },
    },
  },
}
