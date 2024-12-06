return {
    "danymat/neogen",
    cmd = { "Neogen" },
    keys = {
        {
            "<leader>ng",
            function()
                require('neogen').generate({ type = 'func' })
            end,
            mode = "n"
        },
        {
            "<leader>ngc",
            function()
                require('neogen').generate({ type = 'class' })
            end,
            mode = "n"
        }
    },
    config = function()
        require('neogen').setup {
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "reST"
                    }
                }
            }
        }
    end
}
