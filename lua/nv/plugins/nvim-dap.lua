return {
    "mfussenegger/nvim-dap-python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text"
    },
    keys = {
        {
            "<leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
            mode = "n"
        },
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            mode = "n"
        },
        {
            "<F6>",
            function()
                require("dap").step_over()
            end,
            mode = "n"
        },
        {
            "<F2>",
            function()
                require("dap").step_into()
            end,
            mode = "n"
        },
        {
            "<F3>",
            function()
                require("dap").step_out()
            end,
            mode = "n"
        },
    },
    config = function()
        local debugpy_path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"

        require("dap-python").setup(debugpy_path)
        require("nvim-dap-virtual-text").setup({
            virt_text_pos = "eol"
        })

        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}
