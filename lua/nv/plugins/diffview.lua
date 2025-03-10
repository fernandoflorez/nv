return {
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    keys = {
        {
            "<leader>do",
            ":DiffviewOpen<CR>",
            mode = "n"
        },
        {
            "<leader>dc",
            ":DiffviewClose<CR>",
            mode = "n"
        }
    }
}
