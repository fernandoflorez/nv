return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
    config = function()
        local ensure_installed = {
            "lua",
            "python",
            "dockerfile",
            "go",
            "json",
            "markdown",
            "markdown_inline",
            "terraform",
            "yaml",
        }

        local installed = require("nvim-treesitter.config").get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(installed, parser)
            end)
            :totable()
        if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
        end
    end,
}
