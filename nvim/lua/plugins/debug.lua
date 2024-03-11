return {
    {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            opts = {
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            },
            config = function(_, opts)
                local dap = require 'dap'
                local dapui = require 'dapui'
                dapui.setup(opts)

                dap.listeners.after.event_initialized['dapui_config'] = dapui.open
                dap.listeners.before.event_terminated['dapui_config'] = dapui.close
                dap.listeners.before.event_exited['dapui_config'] = dapui.close

            end
        },
    },
        config = function()
            local dap = require('dap')

            -- language configs
            dap.configurations.rust = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                }
            }
        end
    },

    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
            automatic_setup = true,
            handlers = {},
            ensure_installed = {
                'cppdbg',
                'codelldb',
            }
        },
        config = function(_, opts)
            require('mason-nvim-dap').setup(opts)
        end
    }
}
