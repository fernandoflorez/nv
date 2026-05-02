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

        vim.lsp.set_log_level("error")

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
        vim.lsp.config('ty', {
            capabilities = capabilities,
            settings = {
                ty = {
                    diagnosticMode = "workspace",
                    completions = {
                        autoImport = true
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
                "ty",
                "yamlls",
                "graphql",
                "gopls",
                "rust_analyzer"
            },
        })
        require('mason-tool-installer').setup({
            ensure_installed = {
                "goimports",
                "gofumpt",
                "prettierd",
                "jq",
                "terraform-ls",
                "terraform"
            }
        })
    end
}
