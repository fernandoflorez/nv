return {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>xx", function() require("trouble").toggle() end, mode = "n" },
    },
    opts = {}
}
