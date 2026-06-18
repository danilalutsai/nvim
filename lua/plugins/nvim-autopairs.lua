return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require('nvim-autopairs').setup({
            check_ts = true, -- use treesitter to check for things like comments/strings
            disable_filetype = { 'TelescopePrompt' },
        })
    end
}
