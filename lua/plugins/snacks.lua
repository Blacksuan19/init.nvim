local is_vscode = vim.g.vscode ~= nil

return {
    {
        "folke/snacks.nvim",
        cond = not is_vscode,
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true },
            picker = { enabled = true },
            scroll = { enabled = true },
        },
        keys = {
            { "<leader>f",  function() Snacks.picker.files() end,          desc = "Find files" },
            { "<leader>b",  function() Snacks.picker.buffers() end,        desc = "Buffers" },
            { "<leader>c",  function() Snacks.picker.commands() end,       desc = "Commands" },
            { "<leader>t",  function() Snacks.picker.lines() end,          desc = "Buffer lines" },
            { "<leader>/",  function() Snacks.picker.grep() end,           desc = "Live grep" },
            { "<leader>gc", function() Snacks.picker.git_log() end,        desc = "Git commits" },
            { "<leader>gs", function() Snacks.picker.git_status() end,     desc = "Git status" },
            { "<leader>sh", function() Snacks.picker.search_history() end, desc = "Search history" },
            { "<F1>",       function() Snacks.picker.keymaps() end,        mode = { "n", "i", "v" },          desc = "Keymaps" },
        },
        config = function(_, opts)
            require("snacks").setup(opts)

            vim.api.nvim_create_user_command("Files", function(opts2)
                Snacks.picker.files({ cwd = opts2.args ~= "" and opts2.args or nil })
            end, { nargs = "?", bang = true, complete = "dir" })

            vim.api.nvim_create_user_command("Rg", function(opts2)
                if opts2.args ~= "" then
                    Snacks.picker.grep({ search = opts2.args })
                else
                    Snacks.picker.grep()
                end
            end, { nargs = "*", bang = true })

            vim.api.nvim_create_user_command("Buffers", function()
                Snacks.picker.buffers()
            end, {})

            vim.api.nvim_create_user_command("Commands", function()
                Snacks.picker.commands()
            end, {})

            vim.api.nvim_create_user_command("BTags", function()
                Snacks.picker.lines()
            end, {})

            vim.api.nvim_create_user_command("Commits", function()
                Snacks.picker.git_log()
            end, {})
        end,
    },
}
