vim.g.mapleader = " "
vim.opt.belloff = "all"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.wildmode = "list:longest,list:full"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.mouse = ""
vim.opt.clipboard = "unnamed"
-- netrw
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3
-- diagnostics
vim.diagnostic.config({
    virtual_lines = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = ""
    }
})
