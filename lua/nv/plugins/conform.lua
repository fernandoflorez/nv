return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "n"
        }
    },
    opts = {
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters_by_ft = {
            lua = { "lua_ls" },
            python = { "ruff_ls" },
            javascript = { "prettierd" },
            graphql = { "prettierd" },
            docker = { "dockerls" },
            yaml = { "prettierd" }
        }
    },
}
