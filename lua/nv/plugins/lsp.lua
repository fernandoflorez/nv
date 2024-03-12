return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "j-hui/fidget.nvim",
    },
    config = function()
        require("fidget").setup({})
        require("mason").setup({})

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "dockerls",
                "ruff_lsp",
                "pyright",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
                ["ruff_lsp"] = function()
                    require("lspconfig").ruff_lsp.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            client.server_capabilities.hoverProvider = false
                        end
                    })
                end,
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        capabilities = capabilities,
                        settings = {
                            pyright = {
                                disableOrganizeImports = true,
                            },
                            python = {
                                analysis = {
                                    ignore = { '*' },
                                },
                            },
                        },
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    })
                end
            }
        })
    end
}
