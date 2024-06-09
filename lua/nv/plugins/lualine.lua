return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        options = {
            icons_enabled = true,
            theme = "catppuccin",
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            --
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'diagnostics' }
        }
    }
}
