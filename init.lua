require('config.options')
require('config.keybinds')
require('config.lazy')

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "a", "%", { buffer = true, remap = true, desc = "Create file (netrw)" })
    vim.keymap.set("n", "A", "d", { buffer = true, remap = true, desc = "Create directory (netrw)" })
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true, desc = "Open file/folder (netrw)" })
  end,
})

