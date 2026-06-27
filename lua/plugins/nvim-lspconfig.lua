return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        vim.lsp.enable({
            "lua_ls",
            "html",
            "cssls",
            "jsonls",
            "emmet_language_server",
            "bashls",
            "pyright",
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
