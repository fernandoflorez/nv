return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "benfowler/telescope-luasnip.nvim"
    },
    config = function()
        require('telescope').load_extension('luasnip')
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fc", builtin.commands, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>:", builtin.command_history, {})
        vim.keymap.set("n", "<leader>fs", function() require('telescope').extensions.luasnip.luasnip {} end, {})
    end
}
