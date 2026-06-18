return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvim_tree = require("nvim-tree")
        local api = require("nvim-tree.api")

        local function on_attach(bufnr)
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            -- "l" opens file/folder (like <CR>)
            vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))

            -- "h" closes an open folder, or jumps up to parent if on a file/closed folder
            vim.keymap.set("n", "h", function()
                local node = api.tree.get_node_under_cursor()
                if node == nil then
                    return
                end

                if node.nodes ~= nil and node.open then
                    api.node.open.edit() -- closes the open folder
                else
                    api.node.navigate.parent_close() -- collapse parent and move cursor there
                end
            end, opts("Close folder / parent"))
        end

        nvim_tree.setup({
            on_attach = on_attach,
            -- ... your other nvim-tree options
        })

        -- <leader>e: toggle focus between nvim-tree and the file window
        vim.keymap.set("n", "<leader>e", function()
            local view = require("nvim-tree.view")

            if view.is_visible() then
                if vim.bo.filetype == "NvimTree" then
                    vim.cmd("wincmd p") -- jump back to last file window
                else
                    api.tree.focus() -- jump into nvim-tree
                end
            else
                api.tree.open() -- tree isn't open at all, open and focus it
            end
        end, { desc = "Toggle focus: nvim-tree <-> file window", noremap = true, silent = true })
    end
}
