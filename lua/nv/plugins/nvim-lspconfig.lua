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
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "dockerls",
                "ruff",
                "basedpyright",
                "yamlls",
                "graphql",
                "gopls"
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
                ["ruff"] = function()
                    require("lspconfig").ruff.setup({
                        capabilities = capabilities,
                        on_attach = function(client, _)
                            client.server_capabilities.hoverProvider = false
                        end
                    })
                end,
                ["basedpyright"] = function()
                    require("lspconfig").basedpyright.setup({
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
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
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
                end,
                ["yamlls"] = function()
                    require("lspconfig").yamlls.setup({
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
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup({
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                gofumpt = true
                            }
                        }
                    })
                end
            }
        })
        require('mason-tool-installer').setup({
            ensure_installed = {
                "debugpy",
                "goimports",
                "gofumpt"
            }
        })
    end
}
