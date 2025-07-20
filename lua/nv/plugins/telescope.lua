return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        }
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
                -- require("telescope.builtin").live_grep()
                require("telescope").extensions.live_grep_args.live_grep_args()
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
            "<leader>.",
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
        require('telescope').load_extension('live_grep_args')
    end
}
