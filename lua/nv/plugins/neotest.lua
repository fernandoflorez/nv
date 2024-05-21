return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python"
    },
    cmd = { "Neotest" },
    keys = {
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            mode = "n"
        },
        {
            "<leader>tw",
            function()
                require("neotest").run.run()
            end,
            mode = "n"
        }
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")
            }
        })
    end
}
