vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
local statuscolumn = "%{v:virtnum == 0 ? printf('%' .. &numberwidth .. 's', v:relnum == 0 ? v:lnum : v:relnum) : repeat(' ', &numberwidth)}%s"
local padded_statuscolumn = statuscolumn .. " "
vim.opt.statuscolumn = statuscolumn
vim.opt.termguicolors = true

local function sync_window_options()
  local filetype = vim.bo.filetype:lower()
  local bufname = vim.api.nvim_buf_get_name(0):lower()

  if filetype == "netrw" then
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.statuscolumn = ""
  elseif filetype:match("neogit") or vim.bo.buftype ~= "" and bufname:match("neogit") then
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.statuscolumn = ""
    vim.opt_local.cursorline = true
    vim.opt_local.cursorlineopt = "both"
  elseif filetype == "gitcommit" then
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.statuscolumn = padded_statuscolumn
    vim.opt_local.cursorline = true
    vim.opt_local.cursorlineopt = "both"
  elseif vim.bo.buftype == "" then
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.statuscolumn = statuscolumn
    vim.opt_local.cursorline = true
    vim.opt_local.cursorlineopt = "both"
  end
end

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
  callback = sync_window_options,
})

vim.opt.tabstop = 2       -- width a tab character displays as
vim.opt.shiftwidth = 2    -- width used for autoindent/>>/
vim.opt.softtabstop = 2   -- width inserted when pressing Tab
vim.opt.expandtab = true  -- convert tabs to spaces

vim.opt.clipboard = "unnamedplus" -- copies yank to clipboard

vim.opt.autoindent = true

vim.o.updatetime = 250

vim.diagnostic.config({
    virtual_text = {
        spacing = "2",
        source = "if_many",
        prefix = "",
    },
    signs = false,
    float = {
        border = "rounded",
        source = "always",
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
    underline = false,
    undercurl = false,
    fg = "#eb6f92",
})

-- Disables bold text
local function disable_bold_highlights()
  for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
    if group == "CursorLineNr" or group:match("^lualine_") then
      goto continue
    end

    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
    if ok and (hl.bold or hl.cterm and hl.cterm.bold) then
      hl.bold = false
      if hl.cterm then
        hl.cterm.bold = false
      end
      pcall(vim.api.nvim_set_hl, 0, group, hl)
    end

    ::continue::
  end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter", "BufEnter" }, {
  callback = function()
    vim.schedule(disable_bold_highlights)
  end,
})

vim.opt.scrolloff = 6

local function listed_file_buffers_except(current_buf)
  local buffers = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current_buf and vim.bo[bufnr].buflisted and vim.bo[bufnr].filetype ~= "neo-tree" then
      table.insert(buffers, bufnr)
    end
  end

  return buffers
end

vim.api.nvim_create_user_command('Q', function(opts)
  local current_buf = vim.api.nvim_get_current_buf()
  local next_buf = listed_file_buffers_except(current_buf)[1]

  if not next_buf then
    if opts.bang then
      vim.cmd('quitall!')
    else
      vim.cmd('quitall')
    end
    return
  end

  if not opts.bang and vim.bo[current_buf].modified then
    vim.cmd('bdelete ' .. current_buf)
    return
  end

  if next_buf then
    vim.api.nvim_set_current_buf(next_buf)
  end

  if opts.bang then
    vim.cmd('bdelete! ' .. current_buf)
  else
    vim.cmd('bdelete ' .. current_buf)
  end
end, { bang = true })

vim.cmd('cnoreabbrev <expr> q ((getcmdtype() == ":" && getcmdpos() == 3) ? "Q" : "q")')
vim.cmd('cnoreabbrev <expr> q! ((getcmdtype() == ":" && getcmdpos() == 4) ? "Q!" : "q!")')

vim.opt.guicursor = "n:block,i:ver25-blinkon50-blinkoff50"
