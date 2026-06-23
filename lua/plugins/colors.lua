
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                disable_italics = true,
                variant = "auto",
                dark_variant = "main",
            })

            vim.cmd("colorscheme rose-pine-moon")

            -- cycle through rose-pine variants
            local variants = { "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" }
            local current = 1

            vim.keymap.set("n", "<leader>cs", function()
                current = (current % #variants) + 1
                vim.cmd("colorscheme " .. variants[current])
                print("Colorscheme: " .. variants[current])
            end, { desc = "Cycle rose-pine variants", noremap = true, silent = true })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            theme = "rose-pine",
            options = {
                globalstatus = true,
            },
        },
    },
}
