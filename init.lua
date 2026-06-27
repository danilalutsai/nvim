require('config.options')
require('config.keybinds')
require('config.lazy')
require('config.nvim-notify')


vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "netrw",
    "notify",
    "lazy",
    "mason",
  },
  callback = function()
    vim.treesitter.stop()
    vim.keymap.set("n", "a", "%", { buffer = true, remap = true, desc = "Create file (netrw)" })
    vim.keymap.set("n", "A", function()
      local dirname = vim.fn.input("Create directory: ")
      if dirname ~= "" then
        vim.wo.modifiable = true
        vim.fn.mkdir(dirname)
        vim.cmd("e.")
      end
    end, { buffer = true, desc = "Create directory (netrw)" })

    vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true, desc = "Open file/folder (netrw)" })
  end,
})

