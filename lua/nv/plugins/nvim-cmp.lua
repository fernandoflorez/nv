local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        "saadparwaiz1/cmp_luasnip",
        "honza/vim-snippets",
        "onsails/lspkind.nvim",
        "supermaven-inc/supermaven-nvim"
    },
    config = function()
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_snipmate").lazy_load()

        local lspkind = require("lspkind")

        local cmp = require("cmp")
        cmp.setup({
            enabled = function()
                -- disable completion in comments
                local context = require 'cmp.config.context'
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    show_labelDetails = true,
                })
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif luasnip.in_snippet() and luasnip.locally_jumpable() then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),

                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" })
            },
            sources = cmp.config.sources({
                { name = "supermaven", priority = 1 },
                { name = "basedpyright", priority = 1 },
                { name = "nvim_lsp",     priority = 1 },
                { name = "path",         priority = 1 },
                { name = "luasnip",      priority = 0 },
            }, {
                { name = "buffer" },
            }),
        })
    end
}
