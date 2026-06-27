local function block(component, opts)
  return vim.tbl_extend("force", {
    component,
    separator = "",
    padding = { left = 1, right = 1 },
  }, opts or {})
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
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "#313244" },
          },
          insert = {
            a = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "#313244" },
          },
          visual = {
            a = { fg = "#1e1e2e", bg = "#f5c2e7", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "#313244" },
          },
          replace = {
            a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "#313244" },
          },
          command = {
            a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "#313244" },
          },
          inactive = {
            a = { fg = "#bac2de", bg = "#313244" },
            b = { fg = "#bac2de", bg = "#313244" },
            c = { fg = "#bac2de", bg = "#313244" },
          },
        },
      },
      sections = {
        lualine_a = {
          block("mode"),
        },
        lualine_b = {
          block("branch"),
          block("diff"),
          block("diagnostics"),
        },
        lualine_c = {
          block("filename", { color = { fg = "#cdd6f4", bg = "#313244" } }),
        },
        lualine_x = {
          block("encoding", { color = { fg = "#cdd6f4", bg = "#313244" } }),
          block("fileformat", { color = { fg = "#cdd6f4", bg = "#313244" } }),
          block("filetype", { color = { fg = "#cdd6f4", bg = "#313244" } }),
        },
        lualine_y = {
          block("progress"),
        },
        lualine_z = {
          block("location"),
        },
      },
    },
  },
}
