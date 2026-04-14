local is_vscode = vim.g.vscode ~= nil

return {
    {
        "tpope/vim-fugitive",
        cond = not is_vscode,
    },
    {
        "lewis6991/gitsigns.nvim",
        cond = not is_vscode,
        opts = {
            signs = {
                add = { text = "▌" },
                change = { text = "▌" },
                delete = { text = "▌" },
                topdelete = { text = "▌" },
                changedelete = { text = "▌" },
                untracked = { text = "▌" },
            },
            signs_staged = {
                add = { text = "▌" },
                change = { text = "▌" },
                delete = { text = "▌" },
                topdelete = { text = "▌" },
                changedelete = { text = "▌" },
                untracked = { text = "▌" },
            },
            current_line_blame = false,
        },
    }
}
