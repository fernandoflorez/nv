return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup({})

        local cmp_lsp = require("blink.cmp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.get_lsp_capabilities({}, false)
        )
        vim.lsp.config('*', {
            capabilities = capabilities
        })
        vim.lsp.config('ruff', {
            capabilities = capabilities,
            on_attach = function(client, _)
                client.server_capabilities.hoverProvider = false
            end
        })
        vim.lsp.config('basedpyright', {
            capabilities = capabilities,
            settings = {
                basedpyright = {
                    disableOrganizeImports = true,
                    analysis = {
                        ignore = { "*" },
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "standard",
                        diagnosticMode = "openFilesOnly",
                        autoImportCompletions = true,
                    }
                },
            },
        })
        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {
                            "vim",
                            "it",
                            "describe",
                            "before_each",
                            "after_each"
                        },
                    },
                }
            }

        })
        vim.lsp.config('yamlls', {
            capabilities = capabilities,
            settings = {
                yaml = {
                    customTags = {
                        "!Base64",
                        "!Cidr",
                        "!FindInMap sequence",
                        "!GetAtt",
                        "!GetAZs",
                        "!ImportValue",
                        "!Join sequence",
                        "!Ref",
                        "!Select sequence",
                        "!Split sequence",
                        "!Sub sequence",
                        "!Sub",
                        "!And sequence",
                        "!Condition",
                        "!Equals sequence",
                        "!If sequence",
                        "!Not sequence",
                        "!Or sequence",
                    },
                }
            }
        })
        vim.lsp.config('gopls', {
            capabilities = capabilities,
            settings = {
                gopls = {
                    gofumpt = true
                }
            }

        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "dockerls",
                "ruff",
                "basedpyright",
                "yamlls",
                "graphql",
                "gopls",
            },
        })
        require('mason-tool-installer').setup({
            ensure_installed = {
                "debugpy",
                "goimports",
                "gofumpt",
                "prettierd",
                "jq"
            }
        })
    end
}
