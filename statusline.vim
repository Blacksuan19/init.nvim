set noshowmode
set laststatus=2

function! s:HiColor(group, attr, fallback) abort
    let l:id = synIDtrans(hlID(a:group))
    let l:color = synIDattr(l:id, a:attr . '#')
    return empty(l:color) || l:color ==# 'NONE' ? a:fallback : l:color
endfunction

function! s:Contrast(hex) abort
    let l:hex = substitute(a:hex, '^#', '', '')
    if strlen(l:hex) != 6
        return '#11111b'
    endif

    let l:r = str2nr(strpart(l:hex, 0, 2), 16)
    let l:g = str2nr(strpart(l:hex, 2, 2), 16)
    let l:b = str2nr(strpart(l:hex, 4, 2), 16)
    let l:brightness = (299 * l:r + 587 * l:g + 114 * l:b) / 1000
    return l:brightness < 140 ? '#eff1f5' : '#11111b'
endfunction

function! s:Palette() abort
    let l:bg = s:HiColor('Normal', 'bg', '#1d212a')

    return {
                \ 'bg': l:bg,
                \ 'fg': s:HiColor('Normal', 'fg', '#cdd6f4'),
                \ 'surface': l:bg,
                \ 'muted': s:HiColor('Comment', 'fg', '#6c7086'),
                \ 'normal': s:HiColor('Statement', 'fg', s:HiColor('Identifier', 'fg', '#e06c75')),
                \ 'insert': s:HiColor('String', 'fg', s:HiColor('DiffAdd', 'fg', '#a6e3a1')),
                \ 'replace': s:HiColor('ErrorMsg', 'fg', s:HiColor('Constant', 'fg', '#f38ba8')),
                \ 'visual': s:HiColor('Identifier', 'fg', s:HiColor('Function', 'fg', '#89b4fa')),
                \ 'command': s:HiColor('Special', 'fg', '#f5c2e7'),
                \ 'terminal': s:HiColor('Type', 'fg', '#f9e2af'),
                \ 'git': s:HiColor('Identifier', 'fg', s:HiColor('Function', 'fg', '#89b4fa')),
                \ 'filetype': s:HiColor('Special', 'fg', s:HiColor('Type', 'fg', '#cba6f7')),
                \ 'lines': s:HiColor('Type', 'fg', '#f9e2af'),
                \ 'modified': s:HiColor('ErrorMsg', 'fg', s:HiColor('Statement', 'fg', '#e06c75')),
                \ 'saved': s:HiColor('DiffAdd', 'fg', s:HiColor('String', 'fg', '#a6e3a1')),
                \ 'inactive': s:HiColor('Comment', 'fg', '#6c7086'),
                \ }
endfunction

function! s:ModeAccent(mode) abort
    let l:p = s:Palette()
    if a:mode ==# 'i'
        return l:p.insert
    elseif a:mode ==# 'R'
        return l:p.replace
    elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# "\<C-V>"
        return l:p.visual
    elseif a:mode ==# 'c'
        return l:p.command
    elseif a:mode ==# 't'
        return l:p.terminal
    endif
    return l:p.normal
endfunction

function! s:Hi(group, guifg, guibg, style) abort
    execute 'hi ' . a:group
                \ . ' cterm=none ctermbg=NONE ctermfg=NONE'
                \ . ' gui=' . a:style
                \ . ' guifg=' . a:guifg
                \ . ' guibg=' . a:guibg
endfunction

function! s:RefreshStatuslineTheme() abort
    let l:p = s:Palette()
    let l:lines_fg = s:Contrast(l:p.lines)
    let l:git_fg = s:Contrast(l:p.git)

    call s:Hi('StatusLine', l:p.fg, l:p.bg, 'none')
    call s:Hi('StatusLineNC', l:p.inactive, l:p.bg, 'none')
    call s:Hi('MsgArea', l:p.fg, l:p.bg, 'none')
    call s:Hi('MsgSeparator', l:p.fg, l:p.bg, 'none')
    call s:Hi('WinSeparator', l:p.bg, l:p.bg, 'none')
    call s:Hi('CustomStatuslineSeparator', l:p.bg, l:p.bg, 'none')

    call s:Hi('CustomStatuslineTotalLines', l:p.lines, l:p.bg, 'none')
    call s:Hi('CustomStatuslineTotalLinesIcon', l:lines_fg, l:p.lines, 'none')
    call s:Hi('CustomStatuslineTotalLinesBody', l:lines_fg, l:p.lines, 'none')
    call s:Hi('CustomStatuslineTotalLinesSeparator', l:p.lines, l:p.bg, 'none')

    call s:Hi('CustomStatuslineInactive', l:p.inactive, l:p.surface, 'none')
    call s:Hi('CustomStatuslineInactiveSeparator', l:p.bg, l:p.bg, 'none')
    call s:Hi('CustomStatuslineGitbranch', l:p.git, l:p.bg, 'none')
    call s:Hi('CustomStatuslineGitbranchIcon', l:git_fg, l:p.git, 'none')
    call s:Hi('CustomStatuslineGitbranchBody', l:git_fg, l:p.git, 'none')
    call s:Hi('CustomStatuslineGitbranchSeparator', l:p.git, l:p.bg, 'none')
endfunction

function! RedrawModeColors(mode) abort
    let l:p = s:Palette()
    let l:accent = s:ModeAccent(a:mode)
    let l:accent_fg = s:Contrast(l:accent)

    call s:Hi('CustomStatuslineAccent', l:accent, l:p.bg, 'none')
    call s:Hi('CustomStatuslineAccentBody', l:accent_fg, l:accent, 'none')
    call s:Hi('CustomStatuslineFilename', l:accent_fg, l:accent, 'none')
    call s:Hi('CustomStatuslineFilenameSeparator', l:accent, l:p.bg, 'none')
    return ''
endfunction

function! ModeIcon(mode) abort
    if a:mode ==# 'n'
        return ' '
    elseif a:mode ==# 'i'
        return ' '
    elseif a:mode ==# 'R'
        return ' '
    elseif a:mode ==# 'v'
        return '󰈈 '
    elseif a:mode ==# 'V'
        return '󰈈 '
    elseif a:mode ==# "\<C-V>"
        return '󰈈 '
    elseif a:mode ==# 'c'
        return ' '
    elseif a:mode ==# 't'
        return ' '
    endif
    return ' '
endfunction

function! SetModifiedSymbol(modified) abort
    let l:p = s:Palette()
    if a:modified == 1
        call s:Hi('CustomStatuslineModified', l:p.modified, l:p.bg, 'none')
        call s:Hi('CustomStatuslineModifiedBody', s:Contrast(l:p.modified), l:p.modified, 'none')
        call s:Hi('CustomStatuslineModifiedSeparator', l:p.modified, l:p.bg, 'none')
        return '+'
    else
        call s:Hi('CustomStatuslineModified', l:p.saved, l:p.bg, 'none')
        call s:Hi('CustomStatuslineModifiedBody', s:Contrast(l:p.saved), l:p.saved, 'none')
        call s:Hi('CustomStatuslineModifiedSeparator', l:p.saved, l:p.bg, 'none')
        return '='
    endif
endfunction

function! FiletypeIcon() abort
    return winwidth(0) > 70 ? ' ' : ''
endfunction

function! SetFiletype(filetype) abort
    let l:p = s:Palette()

    if winwidth(0) > 70
        let l:filetype_fg = s:Contrast(l:p.filetype)
        call s:Hi('CustomStatuslineFiletype', l:p.filetype, l:p.bg, 'none')
        call s:Hi('CustomStatuslineFiletypeIcon', l:filetype_fg, l:p.filetype, 'none')
        call s:Hi('CustomStatuslineFiletypeBody', l:filetype_fg, l:p.filetype, 'italic')
        call s:Hi('CustomStatuslineFiletypeSeparator', l:p.filetype, l:p.bg, 'none')
        return empty(a:filetype) ? '-' : a:filetype
    endif

    return ''
endfunction

function! GitBranchIcon() abort
    if strlen(FugitiveHead()) > 0 && winwidth(0) > 70
        return ' '
    endif

    return ''
endfunction

function! SetActiveStatusLine() abort
    let l:branch = FugitiveHead()
    let l:statusline  = "%{RedrawModeColors(mode())}"
    let l:statusline .= "%#CustomStatuslineAccent#"
    let l:statusline .= "%#CustomStatuslineAccentBody#%{ModeIcon(mode())}"
    let l:statusline .= "%#CustomStatuslineFilename#\ %t\ "
    let l:statusline .= "%#CustomStatuslineFilenameSeparator#\ "
    let l:statusline .= "%#CustomStatuslineModified#"
    let l:statusline .= "%#CustomStatuslineModifiedBody#%{SetModifiedSymbol(&modified)}"
    let l:statusline .= "%#CustomStatuslineModifiedSeparator#"
    let l:statusline .= "%="
    if strlen(l:branch) > 0 && winwidth(0) > 70
        let l:statusline .= "%#CustomStatuslineGitbranch#"
        let l:statusline .= "%#CustomStatuslineGitbranchIcon#%{GitBranchIcon()}"
        let l:statusline .= "%#CustomStatuslineGitbranchBody#\ " . l:branch . "\ "
        let l:statusline .= "%#CustomStatuslineGitbranchSeparator#\ "
        let l:statusline .= "\ "
    endif
    let l:statusline .= "%#CustomStatuslineTotalLines#"
    let l:statusline .= "%#CustomStatuslineTotalLinesIcon# "
    let l:statusline .= "%#CustomStatuslineTotalLinesBody#\ %l"
    let l:statusline .= "\/\%#CustomStatuslineTotalLinesBody#%L"
    let l:statusline .= "%#CustomStatuslineTotalLinesSeparator#"
    let l:statusline .= "\ "
    let l:statusline .= "%#CustomStatuslineFiletype#"
    let l:statusline .= "%#CustomStatuslineFiletypeIcon#%{FiletypeIcon()}"
    let l:statusline .= "%#CustomStatuslineFiletypeBody#\ %{SetFiletype(&filetype)}"
    let l:statusline .= "%#CustomStatuslineFiletypeSeparator#\ "
    return l:statusline
endfunction

function! SetInactiveStatusLine() abort
    call s:RefreshStatuslineTheme()
    let l:statusline  = "%#CustomStatuslineInactive#"
    let l:statusline .= "%#CustomStatuslineInactive# %t "
    let l:statusline .= "%#CustomStatuslineInactiveSeparator#"
    return l:statusline
endfunction

augroup vimrc-statusline
    autocmd!
    autocmd ColorScheme * call <SID>RefreshStatuslineTheme()
    autocmd VimEnter,BufEnter,WinEnter * call <SID>RefreshStatuslineTheme() | setlocal statusline=%!SetActiveStatusLine()
    autocmd CursorMoved,CursorMovedI * call <SID>RefreshStatuslineTheme()
    autocmd WinLeave * call <SID>RefreshStatuslineTheme() | setlocal statusline=%!SetInactiveStatusLine()
augroup END

call s:RefreshStatuslineTheme()
setlocal statusline=%!SetActiveStatusLine()
