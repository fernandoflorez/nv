return {
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    cmd = { "DiffviewOpen" },
    keys = {
        {
            "<leader>gg",
            function()
                if require("diffview.lib").get_current_view() ~= nil then
                    vim.cmd("DiffviewClose")
                else
                    vim.cmd("DiffviewOpen")
                end
            end,
            mode = "n"
        }
    },
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "DiffviewFiles", "DiffviewFilePanel", "DiffviewFileHistoryPanel" },
            callback = function(args)
                vim.diagnostic.config({ virtual_lines = false }, args.buf)
            end,
        })

        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype
                if not ft:match("^Diffview") then
                    vim.diagnostic.config({ virtual_lines = true }, bufnr)
                end
            end
        })
    end
}
