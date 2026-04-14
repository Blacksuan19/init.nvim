local M = {}

function M.setup()
    if vim.g.vscode ~= nil then
        return
    end

    local ok_ayu, ayu = pcall(require, "ayu")
    if ok_ayu then
        ayu.setup({
            mirage = false,
            terminal = true,
        })
    end

    local ok_auto_dark, auto_dark_mode = pcall(require, "auto-dark-mode")
    if ok_auto_dark then
        auto_dark_mode.setup({
            set_dark_mode = function()
                vim.api.nvim_set_option_value("background", "dark", {})
                if vim.fn.globpath(vim.o.runtimepath, "colors/ayu-dark.lua") ~= "" then
                    vim.cmd("colorscheme ayu-dark")
                end
            end,
            set_light_mode = function()
                vim.api.nvim_set_option_value("background", "light", {})
                if vim.fn.globpath(vim.o.runtimepath, "colors/ayu-light.lua") ~= "" then
                    vim.cmd("colorscheme ayu-light")
                end
            end,
        })
    end

    if vim.o.background == "light" and vim.fn.globpath(vim.o.runtimepath, "colors/ayu-light.lua") ~= "" then
        vim.cmd("silent! colorscheme ayu-light")
    elseif vim.fn.globpath(vim.o.runtimepath, "colors/ayu-dark.lua") ~= "" then
        vim.cmd("silent! colorscheme ayu-dark")
    end
end

return M
