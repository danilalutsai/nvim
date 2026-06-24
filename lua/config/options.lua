vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2       -- width a tab character displays as
vim.opt.shiftwidth = 2    -- width used for autoindent/>>/
vim.opt.softtabstop = 2   -- width inserted when pressing Tab
vim.opt.expandtab = true  -- convert tabs to spaces

vim.opt.clipboard = "unnamedplus" -- copies yank to clipboard


vim.opt.autoindent = true
-- vim.opt.smartindent = true
-- vim.cmd("filetype plugin indent on")

vim.o.updatetime = 250

vim.diagnostic.config({
    virtual_text = {
        spacing = "2",
        source = "if_many",
        prefix = "",
    },
    signs = true,
    float = {
        border = "rounded",
        source = "always",
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
    underline = true,
    fg = "#eb6f92",
})

vim.opt.scrolloff = 6

vim.api.nvim_create_user_command('Q', function(opts)
  local mod = vim.api.nvim_buf_get_option(0, 'modified')
  if opts.bang then vim.cmd('bdelete!') else vim.cmd('bdelete') end
  if vim.fn.bufnr('$') == 0 then vim.cmd('enew') end
end, { bang = true })

vim.cmd('cnoreabbrev <expr> q ((getcmdtype() == ":" && getcmdpos() == 3) ? "Q" : "q")')
vim.cmd('cnoreabbrev <expr> q! ((getcmdtype() == ":" && getcmdpos() == 4) ? "Q!" : "q!")')

vim.opt.guicursor = "n:block,i:block-blinkon50-blinkoff50"

-- Removes bold text from functions and elements in neovim
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, hl in ipairs(vim.fn.getcompletion("", "highlight")) do
      local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = hl })
      if ok and val and val.bold then
        val.bold = false
        pcall(vim.api.nvim_set_hl, 0, hl, val)
      end
    end
  end,
})
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter" }, {
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "EndOfBuffer",
      "SignColumn",
    }

    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})
