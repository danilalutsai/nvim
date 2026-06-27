local function pill(component, opts)
  return vim.tbl_extend("force", {
    component,
    separator = { left = "", right = "" },
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
            c = { fg = "#cdd6f4", bg = "NONE" },
          },
          insert = {
            a = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "NONE" },
          },
          visual = {
            a = { fg = "#1e1e2e", bg = "#f5c2e7", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "NONE" },
          },
          replace = {
            a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "NONE" },
          },
          command = {
            a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
            b = { fg = "#cdd6f4", bg = "#313244" },
            c = { fg = "#cdd6f4", bg = "NONE" },
          },
          inactive = {
            a = { fg = "#6c7086", bg = "NONE" },
            b = { fg = "#6c7086", bg = "NONE" },
            c = { fg = "#6c7086", bg = "NONE" },
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
          pill("filename", { color = { fg = "#cdd6f4", bg = "#313244" } }),
        },
        lualine_x = {
          pill("encoding", { color = { fg = "#cdd6f4", bg = "#313244" } }),
          pill("fileformat", { color = { fg = "#cdd6f4", bg = "#313244" } }),
          pill("filetype", { color = { fg = "#cdd6f4", bg = "#313244" } }),
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
