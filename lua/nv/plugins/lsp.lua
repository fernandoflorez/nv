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
        "hrsh7th/nvim-cmp",
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "rafamadriz/friendly-snippets"
    },
    config = function()
        require("fidget").setup({})
        require("mason").setup({})
        require("luasnip.loaders.from_vscode").lazy_load()

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
                "docker_compose_language_service",
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

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            },
            sources = cmp.config.sources({
                { name = "pyright" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
            experimental = {
                ghost_text = true,
            }
        })
    end
}
