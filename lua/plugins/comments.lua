return {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
        require('Comment').setup({
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })

        -- "/" toggles comment on current line (normal mode)
        vim.keymap.set("n", "?", function()
            require("Comment.api").toggle.linewise.current()
            end, { desc = "Toggle comment on current line", noremap = true, silent = true })

        -- "/" toggles comment on selected lines (visual mode)
        vim.keymap.set("x", "?", function()
            local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
            vim.api.nvim_feedkeys(esc, "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end, { desc = "Toggle comment on selection", noremap = true, silent = true })
    end
}
