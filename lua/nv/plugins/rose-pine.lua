return {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            variant = "moon",
            dark_variant = "moon",
            dim_inactive_windows = true,
            styles = {
                italic = false,
            }
        })
        vim.cmd("colorscheme rose-pine")
    end
}
