return {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>xx", function() require("trouble").toggle() end,                                    mode = "n" },
        { "<leader>xn", function() require("trouble").next({ skip_groups = true, jump = true }) end,   mode = "n" },
        { "<leader>xp", function() require("trouble").previous({ skip_groups = true, jump = true }) end, mode = "n" },
    },
    opts = {}
}
