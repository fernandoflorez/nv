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
		"nvim-telescope/telescope.nvim", tag = "0.1.5",
		dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fc', builtin.commands, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>:', builtin.command_history, {})
        end
	},
	{
		"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
                    "lua", "python", "javascript", "html", "bash",
                    "dockerfile", "json", "typescript", "yaml"
                },
				sync_install = false,
				highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
				indent = {
                    enable = true
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
		"psf/black",
        ft = "python",
        init = function()
            vim.g.black_linelength = 79
            vim.g.black_preview = 1
        end
	},
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        opts = {
            cmdline = {
              format = {
                cmdline = { icon = ">" },
                search_down = { icon = "🔍⌄" },
                search_up = { icon = "🔍⌃" },
                filter = { icon = "$" },
                lua = { icon = "☾" },
                help = { icon = "?" },
              },
            },
            format = {
              level = {
                icons = {
                  error = "✖",
                  warn = "▼",
                  info = "●",
                },
              },
            },
            popupmenu = {
              kind_icons = false,
            },
            inc_rename = {
              cmdline = {
                format = {
                  IncRename = { icon = "⟳" },
                },
              },
            }
        }
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
            "j-hui/fidget.nvim"
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
                    "dockerls",
                    "docker_compose_language_service",
                    "pyright"
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities
                        })
                    end
                }
            })

            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                  expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                  end,
                },
                mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
                }, {
                  { name = 'buffer' },
                })
              })
        end
    }
}
