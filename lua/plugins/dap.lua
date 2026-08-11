return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    event = "VeryLazy",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        require("nvim-dap-virtual-text").setup()

        vim.fn.sign_define("DapBreakpoint", { text = "*", texthl = "", linehl = "", numhl = "" })

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate Debugger" })

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
            },
        }
        dap.configurations.cpp = dap.configurations.c
        dap.adapters["rust-gdb"] = {
            type = "executable",
            command = "rust-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.configurations.rust = {
            {
                name = "Launch",
                type = "rust-gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
            },
        }

        dap.adapters.coreclr = {
            type = "executable",
            command = "netcoredbg",
            args = { "--interpreter=vscode" }
        }
        dap.configurations.cs = {
            {
                name = "Launch",
                type = "coreclr",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
                end,
            },
        }
        dap.configurations.fsharp = dap.configurations.cs

        dap.adapters.delve = function(callback, config)
            if config.mode == "remote" and config.request == "attach" then
                callback({
                    type = "server",
                    host = config.host or "127.0.0.1",
                    port = config.port or "38697"
                })
            else
                callback({
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = "dlv",
                        args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
                        detached = vim.fn.has("win32") == 0,
                    }
                })
            end
        end
        dap.configurations.go = {
            {
                name = "Debug",
                type = "delve",
                request = "launch",
                program = "${file}"
            },
        }

        dap.adapters.python = function(cb, config)
            if config.request == "attach" then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or "127.0.0.1"
                cb({
                    type = "server",
                    port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                    host = host,
                    options = {
                        source_filetype = "python",
                    },
                })
            else
                cb({
                    type = "executable",
                    command = "python",
                    args = { "-m", "debugpy.adapter" },
                    options = {
                        source_filetype = "python",
                    },
                })
            end
        end
        dap.configurations.python = {
            {
                name = "Launch file",
                type = "python",
                request = "launch",
                program = "${file}",
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                        return cwd .. "/venv/bin/python"
                    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                        return cwd .. "/.venv/bin/python"
                    else
                        return "/usr/bin/python"
                    end
                end,
            },
        }
    end,
}
