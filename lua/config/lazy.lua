vim.g.use_lazy_nvim = 1

local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. out)
    end

end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
    },
    install = {
        colorscheme = { "ayu-dark", "ayu-light" },
    },
    change_detection = {
        notify = false,
    },
})
