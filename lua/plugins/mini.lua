local is_vscode = vim.g.vscode ~= nil

return {
    {
        "nvim-mini/mini.nvim",
        cond = not is_vscode,
        config = function()
            require("mini.comment").setup()
            require("mini.icons").setup()
            require("mini.move").setup({
                mappings = {
                    left = "<C-h>",
                    right = "<C-l>",
                    down = "<C-j>",
                    up = "<C-k>",
                    line_left = "<C-h>",
                    line_right = "<C-l>",
                    line_down = "<C-j>",
                    line_up = "<C-k>",
                },
            })
            require("mini.surround").setup()
        end,
    },
}
