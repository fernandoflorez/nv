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
        vim.keymap.set("n", "gr", builtin.lsp_references, {})
        vim.keymap.set("n", "<leader>ds",
            function() builtin.lsp_document_symbols({ ignore_symbols = { "constant", "variable" } }) end,
            {})
        vim.keymap.set("n", "<leader>/", function()
            local opt = require("telescope.themes").get_dropdown({ height = 10, previewer = false })
            builtin.current_buffer_fuzzy_find(opt)
        end, {})
    end
}
