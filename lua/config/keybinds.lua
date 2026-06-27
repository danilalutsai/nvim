-- Leader key
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "h", "-", { buffer = true, remap = true, desc = "Go up directory (netrw)" })
  end,
})
vim.keymap.set("n", "<leader>qcd", ":close<CR><C-w>l", { desc = "Close netrw and move to opened buffer" })

-- Visual mode: Tab indents selection, Shift+Tab un-indents, and keeps selection active
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection", noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent selection", noremap = true, silent = true })

-- Normal mode: Tab indents current line, Shift+Tab un-indents current line
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Un-indent line", noremap = true, silent = true })

-- Re-undo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Moves back or forward one word
vim.keymap.set({"n", "v"}, "<S-h>", "b", { desc = "Move back one word" })
vim.keymap.set({"n", "v"}, "<S-l>", "w", { desc = "Move forward one word" })

-- Goes to the first word of the next paragraph
vim.keymap.set({"n", "v"}, "<C-j>", "}w", { desc = "Go to first word of next paragraph" })

-- Previous or next paragraph
vim.keymap.set({"n", "v"}, "<C-k>", function()
  vim.cmd("normal! {")
  vim.cmd("normal! {")
  vim.cmd("normal! w")
end, { desc = "Go to first word of previous paragraph" })

-- Extends selection back or forward one word
vim.keymap.set("v", "<S-h>", "b", { desc = "Extend selection back one word" })
vim.keymap.set("v", "<S-l>", "w", { desc = "Extend selection forward one word" })

-- Changes next or previous word
vim.keymap.set("n", "c<S-h>", "cb", { desc = "Change word backward" })
vim.keymap.set("n", "c<S-l>", "cw", { desc = "Change word forward" })

-- Deletes previous or next word
vim.keymap.set("n", "d<S-h>", "db", { desc = "Delete word backward" })
vim.keymap.set("n", "d<S-l>", "dw", { desc = "Delete word forward" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")

-- Replaces all selected elements with new entered text
vim.keymap.set("n", "<leader>r", function()
  vim.ui.input({ prompt = "Replace with: " }, function(replacement)
    if replacement then
      vim.cmd("%s//" .. vim.fn.escape(replacement, "/\\") .. "/g")
    end
  end)
end, { desc = "Replace all matches of last search" })


-- Jumps to the end of the line
vim.keymap.set({"n", "i", "v"}, "<C-l>", "<End>", { desc = "Move to end of line" })

-- Jumps to the first character of the line and then to the beginning of the line.
local ctrl_h_state = {
  waiting_for_beginning = false,
  bufnr = nil,
  line = nil,
  first_col = nil,
}

-- Jumps to the first non-empty character of the line then to the beginning of the line in normal mode.
vim.keymap.set("n", "<C-h>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_nr = cursor[1]
  local current_col = cursor[2]

  local line = vim.api.nvim_get_current_line()
  local first_col = vim.fn.match(line, "\\S")

  if first_col == -1 then
    vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
    ctrl_h_state.waiting_for_beginning = false
    return
  end

  local should_jump_to_beginning =
    ctrl_h_state.waiting_for_beginning
    and ctrl_h_state.bufnr == bufnr
    and ctrl_h_state.line == line_nr
    and ctrl_h_state.first_col == first_col
    and current_col == first_col

  if should_jump_to_beginning then
    vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
    ctrl_h_state.waiting_for_beginning = false
  else
    vim.api.nvim_win_set_cursor(0, { line_nr, first_col })
    ctrl_h_state.waiting_for_beginning = true
    ctrl_h_state.bufnr = bufnr
    ctrl_h_state.line = line_nr
    ctrl_h_state.first_col = first_col
  end
end, {
  noremap = true,
  silent = true,
  desc = "Jump to first non-empty character, then beginning of line",
})

-- Jumps to the first non-empty character then to the beginning of the line in visual mode.
vim.keymap.set("v", "<C-h>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_nr = cursor[1]
  local current_col = cursor[2]

  local line = vim.api.nvim_get_current_line()
  local first_col = vim.fn.match(line, "\\S")

  if first_col == -1 then
    vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
    ctrl_h_state.waiting_for_beginning = false
    return
  end

  local should_jump_to_beginning =
    ctrl_h_state.waiting_for_beginning
    and ctrl_h_state.bufnr == bufnr
    and ctrl_h_state.line == line_nr
    and ctrl_h_state.first_col == first_col
    and current_col == first_col

  if should_jump_to_beginning then
    vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
    ctrl_h_state.waiting_for_beginning = false
  else
    vim.api.nvim_win_set_cursor(0, { line_nr, first_col })
    ctrl_h_state.waiting_for_beginning = true
    ctrl_h_state.bufnr = bufnr
    ctrl_h_state.line = line_nr
    ctrl_h_state.first_col = first_col
  end
end, {
  noremap = true,
  silent = true,
  desc = "Jump to first non-empty character, then beginning of line",
})



-- Moves selected line up or down
local function move_current_line(delta)
  vim.cmd(delta < 0 and "move .-2" or "move .+1")
  vim.cmd("normal! ==")
end

local function move_selected_lines(delta)
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line == 0 or end_line == 0 then
    return
  end
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local line_count = vim.api.nvim_buf_line_count(0)
  if delta < 0 and start_line == 1 then
    return
  end
  if delta > 0 and end_line == line_count then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, {})

  local target = delta < 0 and (start_line - 2) or start_line
  vim.api.nvim_buf_set_lines(0, target, target, false, lines)

  local new_start = start_line + delta
  local new_end = end_line + delta
  vim.fn.setpos("'<", { 0, new_start, 1, 0 })
  vim.fn.setpos("'>", { 0, new_end, 1, 0 })
  vim.api.nvim_win_set_cursor(0, { new_end, 0 })
  vim.cmd("normal! gv=gv")
end

-- Moves selected area up or down
vim.keymap.set("n", "<C-S-k>", function() move_current_line(-1) end, { desc = "Move line up" })
vim.keymap.set("n", "<C-S-j>", function() move_current_line(1) end, { desc = "Move line down" })
vim.keymap.set("v", "<C-S-k>", function() move_selected_lines(-1) end, { desc = "Move selection up" })
vim.keymap.set("v", "<C-S-j>", function() move_selected_lines(1) end, { desc = "Move selection down" })

vim.keymap.set("n", "<leader>wh", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>wl", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>wq", ":bdelete<CR>", { desc = "Close current buffer" })
