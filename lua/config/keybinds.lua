vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set({"n", "i", "v"}, "<C-l>", "<End>", { desc = "Move to end of line" })
vim.keymap.set({"n", "v"}, "<C-h>", "^", { desc = "Move to first non-blank character of line" })

-- Visual mode: Tab indents selection, Shift+Tab un-indents, and keeps selection active
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection", noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent selection", noremap = true, silent = true })

-- Normal mode: Tab indents current line, Shift+Tab un-indents current line
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Un-indent line", noremap = true, silent = true })

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.set({"n", "v"}, "<S-h>", "b", { desc = "Move back one word" })
vim.keymap.set({"n", "v"}, "<S-l>", "w", { desc = "Move forward one word" })

vim.keymap.set({"n", "v"}, "<C-j>", "}w", { desc = "Go to first word of next paragraph" })

vim.keymap.set({"n", "v"}, "<C-k>", function()
  vim.cmd("normal! {")
  vim.cmd("normal! {")
  vim.cmd("normal! w")
end, { desc = "Go to first word of previous paragraph" })

vim.keymap.set("v", "<S-h>", "b", { desc = "Extend selection back one word" })
vim.keymap.set("v", "<S-l>", "w", { desc = "Extend selection forward one word" })

vim.keymap.set("n", "c<S-h>", "cb", { desc = "Change word backward" })
vim.keymap.set("n", "c<S-l>", "cw", { desc = "Change word forward" })

vim.keymap.set("n", "d<S-h>", "db", { desc = "Delete word backward" })
vim.keymap.set("n", "d<S-l>", "dw", { desc = "Delete word forward" })
