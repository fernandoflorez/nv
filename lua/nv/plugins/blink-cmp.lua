return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = {
        "honza/vim-snippets",
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            config = function()
                require("luasnip.loaders.from_snipmate").lazy_load()
                print("")
            end
        },
        "onsails/lspkind.nvim",

    },
    version = '1.*',
    opts = {
        keymap = {
            preset = "none",
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                'snippet_forward',
                'fallback'
            },
            ["<S-Tab>"] = {
                'snippet_backward', 'fallback'
            },
            ["<CR>"] = { "accept_and_enter", "fallback" },
            ["<C-j>"] = { 'select_next', 'fallback_to_mappings' },
            ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' }
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
            menu = {
                auto_show = true,
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return require("lspkind").symbolic(ctx.kind, {
                                    mode = "symbol_text",
                                    maxwidth = 50,
                                    ellipsis_char = "...",
                                    show_labelDetails = true
                                })
                            end,
                        },
                    },
                },
            },
        },
        signature = { enabled = true },

        snippets = { preset = 'luasnip' },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
