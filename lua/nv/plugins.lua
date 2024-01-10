return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato"
            })
            vim.cmd("colorscheme catppuccin")
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fc", builtin.commands, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>:", builtin.command_history, {})
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "lua",
                    "python",
                    "dockerfile",
                    "json",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true,
                    disable = { "python" }
                }
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {}
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "¦"
            }
        }
    },
    {
        "airblade/vim-gitgutter"
    },
    {
        "ntpeters/vim-better-whitespace"
    },
    {
        "rcarriga/nvim-notify",
        opts = {
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        opts = {
            popupmenu = {
                kind_icons = false,
            }
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        },
        init = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            vim.g.tmux_navigator_no_wrap = 1
        end
    },
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python"
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    -- LSP
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = {
            "rafamadriz/friendly-snippets"
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
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
                    "docker_compose_language_service",
                    "ruff_lsp",
                    "pyright"
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

                                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                                vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
                                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
                                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end,
                                    bufopts)

                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = buffer,
                                    callback = function()
                                        vim.lsp.buf.format {}
                                    end
                                })
                            end
                        })
                    end,
                    ["pyright"] = function()
                        require("lspconfig").pyright.setup({
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
                        require("lspconfig").lua_ls.setup ({
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = buffer,
                                    callback = function()
                                        vim.lsp.buf.format {}
                                    end
                                })
                            end,
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
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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
}
