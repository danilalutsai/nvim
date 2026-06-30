local function block(component, opts)
  return vim.tbl_extend("force", {
    component,
    separator = "",
    padding = { left = 1, right = 1 },
  }, opts or {})
end

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

local function current_filename()
  local path = vim.fn.expand("%:p")

  if path == "" then
    path = "[No Name]"
  else
    local filename = vim.fn.fnamemodify(path, ":t")
    local directory = vim.fn.fnamemodify(vim.fn.fnamemodify(path, ":h"), ":~:.")
    local folders = vim.split(directory, "/", { trimempty = true })
    local first_folder = math.max(#folders - 2, 1)
    local parts = {}

    for index = first_folder, #folders do
      table.insert(parts, folders[index])
    end

    table.insert(parts, filename)
    path = table.concat(parts, "/")
  end

  if vim.bo.modified then
    return path .. " [+]"
  end

  return path
end

local function color_from_highlight(group, key, fallback)
  local ok, highlight = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })

  if not ok or not highlight[key] then
    return fallback
  end

  return string.format("#%06x", highlight[key])
end

local function current_colors()
  return {
    base = color_from_highlight("Normal", "bg", "#232136"),
    surface = color_from_highlight("CursorLine", "bg", "#2a273f"),
    status_bg = "#393552",
    muted = color_from_highlight("Comment", "fg", "#6e6a86"),
    text = "#e0def4",
    love = color_from_highlight("DiagnosticError", "fg", "#eb6f92"),
    gold = color_from_highlight("DiagnosticWarn", "fg", "#f6c177"),
    rose = color_from_highlight("Special", "fg", "#ea9a97"),
    pine = "#3e8fb0",
    foam = color_from_highlight("Function", "fg", "#9ccfd8"),
    iris = color_from_highlight("Statement", "fg", "#c4a7e7"),
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function setup_lualine()
        local colors = current_colors()

        require("lualine").setup({
          options = {
            globalstatus = true,
            component_separators = " ",
            section_separators = "",
            theme = {
              normal = {
                a = { fg = colors.text, bg = colors.status_bg },
                b = { fg = colors.text, bg = colors.status_bg },
                c = { fg = colors.text, bg = colors.status_bg },
              },
              insert = {
                a = { fg = colors.text, bg = colors.status_bg },
                b = { fg = colors.text, bg = colors.status_bg },
                c = { fg = colors.text, bg = colors.status_bg },
              },
              visual = {
                a = { fg = colors.text, bg = colors.status_bg },
                b = { fg = colors.text, bg = colors.status_bg },
                c = { fg = colors.text, bg = colors.status_bg },
              },
              replace = {
                a = { fg = colors.text, bg = colors.status_bg },
                b = { fg = colors.text, bg = colors.status_bg },
                c = { fg = colors.text, bg = colors.status_bg },
              },
              command = {
                a = { fg = colors.text, bg = colors.status_bg },
                b = { fg = colors.text, bg = colors.status_bg },
                c = { fg = colors.text, bg = colors.status_bg },
              },
              inactive = {
                a = { fg = colors.muted, bg = colors.status_bg },
                b = { fg = colors.muted, bg = colors.status_bg },
                c = { fg = colors.muted, bg = colors.status_bg },
              },
            },
          },
          sections = {
            lualine_a = {
              block(current_filename, { color = { fg = colors.text, bg = colors.status_bg, bold = true } }),
            },
            lualine_b = {
              block("diagnostics"),
            },
            lualine_c = {},
            lualine_x = {
              block("branch"),
              block("diff"),
              block(filetype_with_icon),
            },
            lualine_y = {},
            lualine_z = {
              block("location", { color = { fg = colors.text, bg = colors.status_bg } }),
            },
          },
        })
      end

      setup_lualine()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(setup_lualine)
        end,
      })
    end,
  },
}
