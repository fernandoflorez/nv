return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
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
            "<leader>tt",
            function()
                require("telescope.builtin").diagnostics()
            end,
            mode = "n"
        }
    },
    config = function()
        require('telescope').setup {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            }
        }
        require('telescope').load_extension('fzf')
    end
}
