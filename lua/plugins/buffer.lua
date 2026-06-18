return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
        options = {
            mode = "buffers", -- show buffers, not tabs
            separator_style = "thick",
            show_buffer_close_icons = false,
            show_buffer_icons = false,
            show_close_icon = false,

            -- TAB SIZE
            tab_size = 25,
            diagnostics = "nvim_lsp", -- show LSP error/warning counts on tabs
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
}
