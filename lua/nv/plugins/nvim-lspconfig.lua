return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
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
            on_attach = function(client, _)
                client.server_capabilities.hoverProvider = false
            end
        })
        vim.lsp.config('ty', {
            root_markers = { 'uv.lock', '.git' },
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
            settings = {
                gopls = {
                    gofumpt = true
                }
            }
        })

        local servers = {
            "lua_ls",
            "dockerls",
            "ruff",
            "ty",
            "yamlls",
            "graphql",
            "gopls",
            "rust_analyzer"
        }
        require("mason-lspconfig").setup({
            ensure_installed = servers,
        })
        vim.lsp.enable(servers)
        require('mason-tool-installer').setup({
            ensure_installed = {
                "goimports",
                "gofumpt",
                "prettierd",
                "jq",
                "stylua",
                "terraform-ls",
                "terraform",
                "tree-sitter-cli"
            }
        })
    end
}
