vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

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
    underline = false,
    undercurl = false,
    fg = "#eb6f92",
})

vim.opt.scrolloff = 6

vim.api.nvim_create_user_command('Q', function(opts)
  if opts.bang then vim.cmd('bdelete!') else vim.cmd('bdelete') end
  if vim.fn.bufnr('$') == 0 then vim.cmd('enew') end
end, { bang = true })

vim.cmd('cnoreabbrev <expr> q ((getcmdtype() == ":" && getcmdpos() == 3) ? "Q" : "q")')
vim.cmd('cnoreabbrev <expr> q! ((getcmdtype() == ":" && getcmdpos() == 4) ? "Q!" : "q!")')

vim.opt.guicursor = "n:block,i:block-blinkon50-blinkoff50"
