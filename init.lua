require('config.options')
require('config.keybinds')
require('config.lazy')


vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "a", "%", { buffer = true, remap = true, desc = "Create file (netrw)" })
        vim.keymap.set("n", "A", function()
            local dirname = vim.fn.input("Create directory: ")
            if dirname ~= "" then
                vim.wo.modifiable = true
                vim.fn.mkdir(dirname)
                vim.cmd("e.")
            end
        end, { buffer = true, desc = "Create directory (netrw)" })
        vim.keymap.set("n", "d", function()
            local name = vim.fn.expand("<cfile>")
            local choice = vim.fn.confirm("Delete \"" .. name .. "\"?", "&Yes\n&No", 2)
            if choice == 1 then
                vim.fn.delete(vim.fn.expand("<cfile>"))
                vim.cmd("e.")
            end
        end, { buffer = true, desc = "Delete file/directory (netrw)" })
        vim.keymap.set("n", "D", function()
            local name = vim.fn.expand("<cfile>")
            local choice = vim.fn.confirm("Trash \"" .. name .. "\"?", "&Yes\n&No", 2)
            if choice == 1 then
                local fullpath = vim.fn.expand("<cfile>")
                vim.fn.system({ "osascript", "-e", "tell app \"Finder\" to delete POSIX file \"" .. fullpath .. "\"" })
                vim.cmd("e.")
            end
        end, { buffer = true, desc = "Trash file (netrw)" })
        vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true, desc = "Open file/folder (netrw)" })
    end,
})

