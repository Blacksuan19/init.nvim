local is_vscode = vim.g.vscode ~= nil

return {
    {
        "folke/noice.nvim",
        cond = not is_vscode,
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-notify",
        },
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            lsp = {
                progress = {
                    enabled = true,
                    view = "notify",
                    view_opts = {
                        replace = true,
                        merge = true,
                    },
                },
                message = {
                    enabled = true,
                    view = "notify",
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
                signature = {
                    enabled = true,
                },
            },
            messages = {
                enabled = true,
            },
            popupmenu = {
                enabled = true,
                backend = "cmp",
            },
            notify = {
                enabled = true,
                view = "notify",
            },
            routes = {
                {
                    view = "notify",
                    filter = { event = "lsp", kind = "progress" },
                    opts = { replace = true, merge = true, title = "LSP Progress" },
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
        },
    },
}
