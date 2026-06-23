return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "html",
                "cssls",
                "jsonls",
                "emmet_language_server",
                "bashls",
                "pyright",
                "vtsls",
            },
            automatic_installation = true,
        })
    end,
}
