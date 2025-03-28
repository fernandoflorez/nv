vim.keymap.set("n", "<S-Up>", "<cmd>resize +1<cr>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -1<cr>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -1<cr>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +1<cr>")

local nvGroup = vim.api.nvim_create_augroup("nv", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = nvGroup,
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }

        vim.keymap.set("v", ">", ">gv", opts)
        vim.keymap.set("v", "<", "<gv", opts)
        vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
        vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "x", '"_x')
    end
})
