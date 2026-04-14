local M = {}

vim.o.showmode = false
vim.o.laststatus = 2

local function hi_color(group, attr, fallback)
    local id = vim.fn.synIDtrans(vim.fn.hlID(group))
    local color = vim.fn.synIDattr(id, attr .. "#")
    if color == nil or color == "" or color == "NONE" then
        return fallback
    end
    return color
end

local function contrast(hex)
    local clean = hex:gsub("^#", "")
    if #clean ~= 6 then
        return "#11111b"
    end

    local r = tonumber(clean:sub(1, 2), 16)
    local g = tonumber(clean:sub(3, 4), 16)
    local b = tonumber(clean:sub(5, 6), 16)
    local brightness = (299 * r + 587 * g + 114 * b) / 1000
    return brightness < 140 and "#eff1f5" or "#11111b"
end

local function palette()
    local bg = hi_color("Normal", "bg", "#1d212a")

    return {
        bg = bg,
        fg = hi_color("Normal", "fg", "#cdd6f4"),
        surface = bg,
        muted = hi_color("Comment", "fg", "#6c7086"),
        normal = hi_color("Statement", "fg", hi_color("Identifier", "fg", "#e06c75")),
        insert = hi_color("String", "fg", hi_color("DiffAdd", "fg", "#a6e3a1")),
        replace = hi_color("ErrorMsg", "fg", hi_color("Constant", "fg", "#f38ba8")),
        visual = hi_color("Identifier", "fg", hi_color("Function", "fg", "#89b4fa")),
        command = hi_color("Special", "fg", "#f5c2e7"),
        terminal = hi_color("Type", "fg", "#f9e2af"),
        git = hi_color("Identifier", "fg", hi_color("Function", "fg", "#89b4fa")),
        filetype = hi_color("Special", "fg", hi_color("Type", "fg", "#cba6f7")),
        lines = hi_color("Type", "fg", "#f9e2af"),
        modified = hi_color("ErrorMsg", "fg", hi_color("Statement", "fg", "#e06c75")),
        saved = hi_color("DiffAdd", "fg", hi_color("String", "fg", "#a6e3a1")),
        inactive = hi_color("Comment", "fg", "#6c7086"),
    }
end

local function mode_accent(mode)
    local p = palette()
    if mode == "i" then
        return p.insert
    elseif mode == "R" then
        return p.replace
    elseif mode == "v" or mode == "V" or mode == "\022" then
        return p.visual
    elseif mode == "c" then
        return p.command
    elseif mode == "t" then
        return p.terminal
    end
    return p.normal
end

local function set_hl(group, fg, bg, style)
    vim.api.nvim_set_hl(0, group, {
        fg = fg,
        bg = bg,
        italic = style == "italic",
        bold = style == "bold",
    })
end

local function refresh_theme()
    local p = palette()
    local lines_fg = contrast(p.lines)
    local git_fg = contrast(p.git)

    set_hl("StatusLine", p.fg, p.bg, "none")
    set_hl("StatusLineNC", p.inactive, p.bg, "none")
    set_hl("MsgArea", p.fg, p.bg, "none")
    set_hl("MsgSeparator", p.fg, p.bg, "none")
    set_hl("WinSeparator", p.bg, p.bg, "none")
    set_hl("CustomStatuslineSeparator", p.bg, p.bg, "none")

    set_hl("CustomStatuslineTotalLines", p.lines, p.bg, "none")
    set_hl("CustomStatuslineTotalLinesIcon", lines_fg, p.lines, "none")
    set_hl("CustomStatuslineTotalLinesBody", lines_fg, p.lines, "none")
    set_hl("CustomStatuslineTotalLinesSeparator", p.lines, p.bg, "none")

    set_hl("CustomStatuslineInactive", p.inactive, p.surface, "none")
    set_hl("CustomStatuslineInactiveSeparator", p.bg, p.bg, "none")
    set_hl("CustomStatuslineGitbranch", p.git, p.bg, "none")
    set_hl("CustomStatuslineGitbranchIcon", git_fg, p.git, "none")
    set_hl("CustomStatuslineGitbranchBody", git_fg, p.git, "none")
    set_hl("CustomStatuslineGitbranchSeparator", p.git, p.bg, "none")
end

function _G.RedrawModeColors(mode)
    local p = palette()
    local accent = mode_accent(mode)
    local accent_fg = contrast(accent)

    set_hl("CustomStatuslineAccent", accent, p.bg, "none")
    set_hl("CustomStatuslineAccentBody", accent_fg, accent, "none")
    set_hl("CustomStatuslineFilename", accent_fg, accent, "none")
    set_hl("CustomStatuslineFilenameSeparator", accent, p.bg, "none")
    return ""
end

function _G.ModeIcon(mode)
    if mode == "n" then
        return " "
    elseif mode == "i" then
        return " "
    elseif mode == "R" then
        return " "
    elseif mode == "v" or mode == "V" or mode == "\022" then
        return "󰈈 "
    elseif mode == "c" then
        return " "
    elseif mode == "t" then
        return " "
    end
    return " "
end

function _G.SetModifiedSymbol(modified)
    local p = palette()
    if modified == 1 then
        set_hl("CustomStatuslineModified", p.modified, p.bg, "none")
        set_hl("CustomStatuslineModifiedBody", contrast(p.modified), p.modified, "none")
        set_hl("CustomStatuslineModifiedSeparator", p.modified, p.bg, "none")
        return "+"
    end

    set_hl("CustomStatuslineModified", p.saved, p.bg, "none")
    set_hl("CustomStatuslineModifiedBody", contrast(p.saved), p.saved, "none")
    set_hl("CustomStatuslineModifiedSeparator", p.saved, p.bg, "none")
    return "="
end

function _G.FiletypeIcon()
    return vim.fn.winwidth(0) > 70 and " " or ""
end

function _G.SetFiletype(filetype)
    local p = palette()

    if vim.fn.winwidth(0) > 70 then
        local filetype_fg = contrast(p.filetype)
        set_hl("CustomStatuslineFiletype", p.filetype, p.bg, "none")
        set_hl("CustomStatuslineFiletypeIcon", filetype_fg, p.filetype, "none")
        set_hl("CustomStatuslineFiletypeBody", filetype_fg, p.filetype, "italic")
        set_hl("CustomStatuslineFiletypeSeparator", p.filetype, p.bg, "none")
        return filetype ~= "" and filetype or "-"
    end

    return ""
end

function _G.GitBranchIcon()
    local ok, fugitive = pcall(vim.fn.FugitiveHead)
    if ok and fugitive ~= "" and vim.fn.winwidth(0) > 70 then
        return " "
    end
    return ""
end

function _G.SetActiveStatusLine()
    local ok, branch = pcall(vim.fn.FugitiveHead)
    branch = ok and branch or ""

    local statusline = "%{v:lua.RedrawModeColors(mode())}"
    statusline = statusline .. "%#CustomStatuslineAccent#"
    statusline = statusline .. "%#CustomStatuslineAccentBody#%{v:lua.ModeIcon(mode())}"
    statusline = statusline .. "%#CustomStatuslineFilename# %t "
    statusline = statusline .. "%#CustomStatuslineFilenameSeparator# "
    statusline = statusline .. "%#CustomStatuslineModified#"
    statusline = statusline .. "%#CustomStatuslineModifiedBody#%{v:lua.SetModifiedSymbol(&modified)}"
    statusline = statusline .. "%#CustomStatuslineModifiedSeparator#"
    statusline = statusline .. "%="

    if branch ~= "" and vim.fn.winwidth(0) > 70 then
        statusline = statusline .. "%#CustomStatuslineGitbranch#"
        statusline = statusline .. "%#CustomStatuslineGitbranchIcon#%{v:lua.GitBranchIcon()}"
        statusline = statusline .. "%#CustomStatuslineGitbranchBody# " .. branch .. " "
        statusline = statusline .. "%#CustomStatuslineGitbranchSeparator# "
        statusline = statusline .. " "
    end

    statusline = statusline .. "%#CustomStatuslineTotalLines#"
    statusline = statusline .. "%#CustomStatuslineTotalLinesIcon# "
    statusline = statusline .. "%#CustomStatuslineTotalLinesBody# %l"
    statusline = statusline .. "/%#CustomStatuslineTotalLinesBody#%L"
    statusline = statusline .. "%#CustomStatuslineTotalLinesSeparator#"
    statusline = statusline .. " "
    statusline = statusline .. "%#CustomStatuslineFiletype#"
    statusline = statusline .. "%#CustomStatuslineFiletypeIcon#%{v:lua.FiletypeIcon()}"
    statusline = statusline .. "%#CustomStatuslineFiletypeBody# %{v:lua.SetFiletype(&filetype)}"
    statusline = statusline .. "%#CustomStatuslineFiletypeSeparator# "
    return statusline
end

function _G.SetInactiveStatusLine()
    refresh_theme()
    local statusline = "%#CustomStatuslineInactive#"
    statusline = statusline .. "%#CustomStatuslineInactive# %t "
    statusline = statusline .. "%#CustomStatuslineInactiveSeparator#"
    return statusline
end

function M.setup()
    local group = vim.api.nvim_create_augroup("migration-statusline", { clear = true })

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = refresh_theme,
    })

    vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter" }, {
        group = group,
        callback = function()
            refresh_theme()
            vim.opt_local.statusline = "%!v:lua.SetActiveStatusLine()"
        end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        callback = refresh_theme,
    })

    vim.api.nvim_create_autocmd("WinLeave", {
        group = group,
        callback = function()
            refresh_theme()
            vim.opt_local.statusline = "%!v:lua.SetInactiveStatusLine()"
        end,
    })

    refresh_theme()
    vim.opt.statusline = "%!v:lua.SetActiveStatusLine()"
end

return M
