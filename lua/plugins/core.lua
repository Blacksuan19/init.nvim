local is_vscode = vim.g.vscode ~= nil

return {
    { "tpope/vim-eunuch" },
    {
        "Shatur/neovim-ayu",
        cond = not is_vscode,
    },
    {
        "gregsexton/MatchTag",
        cond = not is_vscode,
    },
    {
        "f-person/auto-dark-mode.nvim",
        cond = not is_vscode,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        cond = not is_vscode,
    },
    {
        "christoomey/vim-tmux-navigator",
        cond = not is_vscode,
    },
}
