return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files()
            end,
            mode = "n"
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep()
            end,
            mode = "n"
        },
        {
            "<leader>fc",
            function()
                require("telescope.builtin").commands()
            end,
            mode = "n"
        },
        {
            "<leader>:",
            function()
                require("telescope.builtin").command_history()
            end,
            mode = "n"
        },
        {
            "<leader>ds",
            function()
                require("telescope.builtin").lsp_document_symbols({ ignore_symbols = { "constant", "variable" } })
            end,
            mode = "n"
        },
        {
            "<leader>/",
            function()
                local opt = require("telescope.themes").get_dropdown({ height = 10, previewer = false })
                require("telescope.builtin").current_buffer_fuzzy_find(opt)
            end,
            mode = "n"
        }
    },
    opts = {}
    -- config = function()
    --     local builtin = require("telescope.builtin")
    --
    --     vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    --     vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    --     vim.keymap.set("n", "<leader>fc", builtin.commands, {})
    --     vim.keymap.set("n", "<leader>:", builtin.command_history, {})
    --     vim.keymap.set("n", "gr", builtin.lsp_references, {})
    --     vim.keymap.set("n", "<leader>ds",
    --         function() builtin.lsp_document_symbols({ ignore_symbols = { "constant", "variable" } }) end,
    --         {})
    --     vim.keymap.set("n", "<leader>/", function()
    --         local opt = require("telescope.themes").get_dropdown({ height = 10, previewer = false })
    --         builtin.current_buffer_fuzzy_find(opt)
    --     end, {})
    -- end
}
