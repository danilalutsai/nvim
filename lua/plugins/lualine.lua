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
            a = { fg = "#11111b", bg = "#89b4fa", gui = "bold" },
            b = { fg = "#89b4fa", bg = "#181825" },
            c = { fg = "#cdd6f4", bg = "#181825" },
          },
          insert = {
            a = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" },
            b = { fg = "#89b4fa", bg = "#181825" },
            c = { fg = "#cdd6f4", bg = "#181825" },
          },
          visual = {
            a = { fg = "#1e1e2e", bg = "#fab387", gui = "bold" },
            b = { fg = "#89b4fa", bg = "#181825" },
            c = { fg = "#cdd6f4", bg = "#181825" },
          },
          replace = {
            a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
            b = { fg = "#89b4fa", bg = "#181825" },
            c = { fg = "#cdd6f4", bg = "#181825" },
          },
          command = {
            a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
            b = { fg = "#89b4fa", bg = "#181825" },
            c = { fg = "#cdd6f4", bg = "#181825" },
          },
          inactive = {
            a = { fg = "#6c7086", bg = "#11111b" },
            b = { fg = "#6c7086", bg = "#11111b" },
            c = { fg = "#6c7086", bg = "#11111b" },
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
          block("filename", { color = { fg = "#cdd6f4", bg = "#181825" } }),
        },
        lualine_x = {
          block("encoding", { color = { fg = "#89b4fa", bg = "#181825" } }),
          block("fileformat", { color = { fg = "#89b4fa", bg = "#181825" } }),
          block("filetype", { color = { fg = "#89b4fa", bg = "#181825" } }),
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
