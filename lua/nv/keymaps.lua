vim.keymap.set("n", "<leader>.", vim.cmd.Ex)
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>")

local nvGroup = vim.api.nvim_create_augroup("nv", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = nvGroup,
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("v", "<Tab>", ">gv", opts)
        vim.keymap.set("v", "<S-Tab>", "<gv", opts)
        vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
        vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "x", '"_x')
    end
})
