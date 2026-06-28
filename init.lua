local startup_dir = nil

if vim.fn.argc() == 1 then
  local path = vim.fn.argv(0)
  if vim.fn.isdirectory(path) == 1 then
    startup_dir = path
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end
end

require('config.options')
require('config.keybinds')
require('config.lazy')
require('config.nvim-notify')

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if not startup_dir then
      return
    end

    vim.cmd.cd(vim.fn.fnameescape(startup_dir))

    vim.schedule(function()
      require("lazy").load({ plugins = { "neo-tree.nvim" } })
      require("neo-tree.command").execute({
        action = "focus",
        source = "filesystem",
        position = "current",
        dir = startup_dir,
      })
    end)
  end,
})


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
