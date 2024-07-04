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
            require("dap").toggle_breakpoint,
            mode = "n"
        },
        {
            "<F5>",
            require("dap").continue,
            mode = "n"
        },
        {
            "<F6>",
            require("dap").step_over,
            mode = "n"
        },
        {
            "<F2>",
            require("dap").step_into,
            mode = "n"
        },
        {
            "<F3>",
            require("dap").step_out,
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
