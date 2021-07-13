   " _____   __            __                     __     _
  " / ___/  / /_  ____ _  / /_  __  __   _____   / /    (_)   ____   ___
  " \__ \  / __/ / __ `/ / __/ / / / /  / ___/  / /    / /   / __ \ / _ \
 " ___/ / / /_  / /_/ / / /_  / /_/ /  (__  )  / /___ / /   / / / //  __/
" /____/  \__/  \__,_/  \__/  \__,_/  /____/  /_____//_/   /_/ /_/ \___/

set noshowmode
set laststatus=2

function! RedrawModeColors(mode) " {{{
    " Normal mode
    if a:mode == 'n'
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=1   guibg=none    guifg=#fc8993
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=1    ctermfg=0   guibg=#fc8993 guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=251 guibg=#272c38 guifg=#fc8993
        " Insert mode
    elseif a:mode == 'i'
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=2   guibg=none    guifg=#8de19f
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=2    ctermfg=0   guibg=#8de19f guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=251 guibg=#272c38 guifg=#8de19f
        " Replace mode
    elseif a:mode == 'R'
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=1   guibg=none    guifg=#A65169
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=1    ctermfg=0   guibg=#A65169 guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=251 guibg=#272c38 guifg=#A65169
        " Visual mode
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == "\<C-V>"
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=7   guibg=none    guifg=#a7bdfb
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=7    ctermfg=0   guibg=#a7bdfb guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=7 guibg=#272c38 guifg=#a7bdfb
        " Command mode
    elseif a:mode == 'c'
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=6   guibg=none    guifg=#ee828c
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=6    ctermfg=0   guibg=#ee828c guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=6 guibg=#272c38 guifg=#ee828c
        " Terminal mode
    elseif a:mode == 't'
        hi CustomStatuslineAccent     cterm=none gui=none ctermbg=none ctermfg=3   guibg=none    guifg=#fbdf90
        hi CustomStatuslineAccentBody cterm=none gui=none ctermbg=3    ctermfg=0   guibg=#fbdb90 guifg=#272c38
        hi CustomStatuslineFilename   cterm=none gui=none ctermbg=8    ctermfg=3 guibg=#272c38 guifg=#fbdb90
    endif
    return ''
endfunction
" }}}
function! ModeIcon(mode) " {{{
    " Normal mode
    if a:mode == 'n'
        return '煮'
        " Insert mode
    elseif a:mode == 'i'
        return ' '
        " Replace mode
    elseif a:mode == 'R'
        return ' '
        " Visual mode
    elseif a:mode == 'v'
        return ' '
    elseif a:mode == 'V'
        return ' '
    elseif a:mode == "\<C-V>"
        return '礪'
        " Command mode
    elseif a:mode == 'c'
        return '⌘ '
        " Terminal mode
    elseif a:mode == 't'
        return 'ﰣ '
    endif
    return ''
endfunction

function! SetModifiedSymbol(modified) " {{{
    if a:modified == 1
        hi CustomStatuslineModifiedBody cterm=none gui=none ctermbg=1 ctermfg=0 guibg=#fc8993 guifg=#272c38
        hi CustomStatuslineModified cterm=none gui=none ctermbg=none ctermfg=1 guibg=none guifg=#fc8993
    else
        hi CustomStatuslineModifiedBody cterm=none gui=none ctermbg=0 ctermfg=2 guibg=#1d212a guifg=#89e19c
        hi CustomStatuslineModified cterm=none gui=none ctermbg=0 ctermfg=0 guibg=none guifg=#1d212a
    endif
    return ''
endfunction

function! FiletypeIcon()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' : ' ') : ''
endfunction
function! SetFiletype(filetype) " {{{
    if winwidth(0) > 70
        hi CustomStatuslineFiletype          cterm=none   gui=none   ctermbg=none ctermfg=5 guibg=none    guifg=#d990cd
        hi CustomStatuslineFiletypeIcon      cterm=none   gui=none   ctermbg=5 ctermfg=0 guibg=#d990cd guifg=#272c38
        hi CustomStatuslineFiletypeBody      cterm=italic gui=italic ctermbg=8    ctermfg=5 guibg=#272c38 guifg=#d990cd
        hi CustomStatuslineFiletypeSeparator cterm=none   gui=none   ctermbg=none ctermfg=8 guibg=none    guifg=#272c38
        if a:filetype == ''
            return '-'
        else
            return a:filetype
        endif
    else
        hi CustomStatuslineFiletype          cterm=none   gui=none   ctermbg=none ctermfg=5 guibg=none    guifg=#1d212a
        hi CustomStatuslineFiletypeIcon      cterm=none   gui=none   ctermbg=5 ctermfg=0 guibg=#1d212a guifg=#1d212a
        hi CustomStatuslineFiletypeBody      cterm=italic gui=italic ctermbg=5    ctermfg=5 guibg=#1d212a guifg=#1d212a
        hi CustomStatuslineFiletypeSeparator cterm=none   gui=none   ctermbg=none ctermfg=5 guibg=none    guifg=#1d212a
        return ''
    endif
endfunction

function GitBranchIcon()
    if strlen(FugitiveHead())>0 && winwidth(0) > 70
        hi CustomStatuslineGitbranch          cterm=none gui=none ctermbg=none ctermfg=4 guibg=none    guifg=#81d4ee
        hi CustomStatuslineGitbranchIcon      cterm=none gui=none ctermbg=4 ctermfg=0 guibg=#81d4ee guifg=#272c38
        hi CustomStatuslineGitbranchBody      cterm=none gui=none ctermbg=8    ctermfg=4 guibg=#272c38 guifg=#81d4ee
        hi CustomStatuslineGitbranchSeparator cterm=none gui=none ctermbg=none ctermfg=8 guibg=none    guifg=#272c38
        return ' '
    else
        hi CustomStatuslineGitbranch          cterm=none gui=none ctermbg=none ctermfg=0 guibg=none    guifg=#1d212a
        hi CustomStatuslineGitbranchIcon      cterm=none gui=none ctermbg=0    ctermfg=0 guibg=#1d212a guifg=#1d212a
        hi CustomStatuslineGitbranchBody      cterm=none gui=none ctermbg=0    ctermfg=0 guibg=#1d212a guifg=#1d212a
        hi CustomStatuslineGitbranchSeparator cterm=none gui=none ctermbg=none ctermfg=0 guibg=none    guifg=#1d212a
        return ''
    endif
endfunction


function! Shiftwidth()
    let fname = expand('%:t')
    if ! &expandtab || fname == 'ControlP'
        return '-'
    endif
    if &shiftwidth == 0
        return &tabstop
    else
        return &shiftwidth
    endif
endfunction

" Setup the colors
hi StatusLine                cterm=none gui=none ctermbg=8 ctermfg=3 guibg=none guifg=none
hi CustomStatuslineSeparator cterm=none gui=none ctermbg=none ctermfg=8 guibg=none guifg=#272c38

hi CustomStatuslinePercentage     ctermfg=0 cterm=NONE ctermbg=NONE
hi CustomStatuslinePercentageBody ctermbg=0 cterm=none ctermfg=6

hi CustomStatuslineTotalLines     cterm=none gui=none ctermbg=none ctermfg=3 guibg=none guifg=#fbdf90
hi CustomStatuslineTotalLinesIcon cterm=none gui=none ctermbg=3 ctermfg=0 guibg=#fbdf90 guifg=#272c38
hi CustomStatuslineTotalLinesBody cterm=none gui=none ctermbg=8    ctermfg=3 guibg=#272c38 guifg=#fbdf90
hi CustomStatuslineTotalLinesSeparator cterm=none gui=none ctermbg=none ctermfg=8 guibg=none guifg=#272c38

hi CustomStatuslineInactiveDark           cterm=none gui=none ctermbg=8 ctermfg=12 guibg=#44506c guifg=#a7bdfb
hi CustomStatuslineInactiveDarkSeparator  cterm=none gui=none ctermbg=8 ctermfg=12 guibg=none    guifg=#272c38
hi CustomStatuslineInactiveLight          cterm=none gui=none ctermbg=8 ctermfg=12 guibg=none guifg=#44506c
hi CustomStatuslineInactiveLightSeparator cterm=none gui=none ctermbg=8 ctermfg=12 guibg=none    guifg=#44506c

function! SetActiveStatusLine()
    " Statusbar items
    let statusline  = "%{RedrawModeColors(mode())}"
    " Left side items
    " =======================
    let statusline .= "%#CustomStatuslineAccent#"
    let statusline .= "%#CustomStatuslineAccentBody#%{ModeIcon(mode())}"
    let statusline .= "%#CustomStatuslineFilename#\ %t\ "
    let statusline .= "%#CustomStatuslineSeparator#\ "
    " Modified status
    let statusline .= "%#CustomStatuslineModified#"
    let statusline .= "%#CustomStatuslineModifiedBody#%{SetModifiedSymbol(&modified)}"
    let statusline .= "%#CustomStatuslineModified#"
    " Right side items
    " =======================
    let statusline .= "%="
    " Git branch name
    let statusline .= "%#CustomStatuslineGitbranch#"
    let statusline .= "%#CustomStatuslineGitbranchIcon#%{GitBranchIcon()}"
    let statusline .= "%#CustomStatuslineGitbranchBody#\ %{FugitiveHead()}"
    let statusline .= "%#CustomStatuslineGitbranchSeparator#\ "
    " Padding
    let statusline .= "\ "
    " Current line / total number of lines
    let statusline .= "%#CustomStatuslineTotalLines#"
    let statusline .= "%#CustomStatuslineTotalLinesIcon# "
    let statusline .= "%#CUSTomStatuslineTotalLinesBody#\ %l"
    let statusline .= "\/\%#CUSTomStatuslineTotalLinesBody#%L"
    let statusline .= "%#CustomStatuslineTotalLinesSeparator#"
    " Padding
    let statusline .= "\ "
    " Filetype
    let statusline .= "%#CustomStatuslineFiletype#"
    let statusline .= "%#CustomStatuslineFiletypeIcon#%{FiletypeIcon()}"
    let statusline .= "%#CustomStatuslineFiletypeBody#\ %{SetFiletype(&filetype)}"
    let statusline .= "%#CustomStatuslineFiletypeSeparator#\ "
    return statusline
endfunction

function! SetInactiveStatusLine()
    " Statusbar items
    let statusline  = "%{RedrawModeColors(mode())}"
    " Left side items
    " =======================
    let statusline .= "%#CustomStatuslineAccent#"
    let statusline .= "%#CustomStatuslineAccentBody#%{ModeIcon(mode())}"
    let statusline .= "%#CustomStatuslineFilename#\ %t\ "
    let statusline .= "%#CustomStatuslineSeparator#\ "
    " Modified status
    let statusline .= "%#CustomStatuslineModified#"
    let statusline .= "%#CustomStatuslineModifiedBody#%{SetModifiedSymbol(&modified)}"
    let statusline .= "%#CustomStatuslineModified#"
    " Right side items
    " =======================
    let statusline .= "%="
    " Git branch name
    let statusline .= "%#CustomStatuslineGitbranch#"
    let statusline .= "%#CustomStatuslineGitbranchIcon#%{GitBranchIcon()}"
    let statusline .= "%#CustomStatuslineGitbranchBody#\ %{FugitiveHead()}"
    let statusline .= "%#CustomStatuslineGitbranchSeparator#\ "
    " Padding
    let statusline .= "\ "
    " Current line / total number of lines
    let statusline .= "%#CustomStatuslineTotalLines#"
    let statusline .= "%#CustomStatuslineTotalLinesIcon# "
    let statusline .= "%#CUSTomStatuslineTotalLinesBody#\ %l"
    let statusline .= "\/\%#CUSTomStatuslineTotalLinesBody#%L"
    let statusline .= "%#CustomStatuslineTotalLinesSeparator#"
    " Padding
    let statusline .= "\ "
    " Filetype
    let statusline .= "%#CustomStatuslineFiletype#"
    let statusline .= "%#CustomStatuslineFiletypeIcon#%{FiletypeIcon()}"
    let statusline .= "%#CustomStatuslineFiletypeBody#\ %{SetFiletype(&filetype)}"
    let statusline .= "%#CustomStatuslineFiletypeSeparator#\ "
    return statusline
endfunction

augroup vimrc-statusline
    autocmd!
    autocmd WinEnter * setlocal statusline=%!SetActiveStatusLine()
    autocmd BufEnter * setlocal statusline=%!SetActiveStatusLine()
    autocmd WinNew   * setlocal statusline=%!SetActiveStatusLine()
    autocmd WinLeave * setlocal statusline=%!SetActiveStatusLine()
augroup END
setlocal statusline=%!SetActiveStatusLine()
