return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "vtsls",
            },
        })

        vim.lsp.enable({
            "vtsls",
        })

        -- fix "Undefined global vim" warning in lua_ls
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
    end,
}
