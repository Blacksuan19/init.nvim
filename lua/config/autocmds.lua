local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local core = augroup("migration-core", { clear = true })
local modern_workflow = augroup("migration-modern-workflow", { clear = true })

autocmd("BufEnter", {
    group = core,
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

autocmd("FileType", {
    group = core,
    pattern = "help",
    command = "wincmd L",
})

autocmd("BufWritePre", {
    group = core,
    pattern = "*",
    command = [[silent! %s/\s\+$//e]],
})

autocmd("BufReadPost", {
    group = core,
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd.normal({ "g`\"", bang = true })
        end
    end,
})

if vim.g.vscode == nil then
    autocmd("VimEnter", {
        group = modern_workflow,
        callback = function()
            if vim.fn.argc() == 0 then
                vim.schedule(function()
                    pcall(function()
                        require("alpha").start(false, require("alpha.themes.startify").config)
                    end)
                end)
                return
            end

            local arg0 = tostring(vim.fn.argv(0))
            if vim.fn.argc() > 0 and vim.fn.isdirectory(arg0) == 1 then
                vim.cmd.cd(vim.fn.fnameescape(arg0))
                pcall(function()
                    Snacks.picker.files({ cwd = arg0 })
                end)
            end
        end,
    })
end
