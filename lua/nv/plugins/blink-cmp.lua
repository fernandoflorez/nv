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
            end
        },
    },
    version = '1.*',
    opts = {
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
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
            ["<CR>"] = { "accept", "fallback" },
            ["<C-j>"] = { 'select_next', 'fallback_to_mappings' },
            ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' }
        },

        cmdline = {
            keymap = {
                preset = "inherit"
            },
            completion = {
                list = {
                    selection = {
                        preselect = false
                    }
                },
                menu = {
                    auto_show = true
                }
            }
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
            menu = {
                auto_show = true,
            },
        },
        signature = { enabled = false },

        snippets = { preset = 'luasnip' },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
