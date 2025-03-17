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
        -- {
        --     "<leader>do",
        --     ":DiffviewOpen<CR>",
        --     mode = "n"
        -- },
        -- {
        --     "<leader>dc",
        --     ":DiffviewClose<CR>",
        --     mode = "n"
        -- }
    }
}
