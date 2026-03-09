" ==============================================================================
" GitHub Dark Dimmed - Full Vim Colorscheme
" Palette based on GitHub Dark Dimmed UI
" ==============================================================================

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "github"

" ------------------------------------------------------------------------------
" Palette
" ------------------------------------------------------------------------------
let s:bg        = "#22272e"
let s:bg_alt    = "#2d333b"
let s:bg_sel    = "#444c56"
let s:border    = "#373e47"
let s:fg        = "#adbac7"
let s:comment   = "#768390"
let s:line      = "#545d68"

let s:red       = "#f47067"
let s:orange    = "#f69d50"
let s:yellow    = "#d29922"
let s:green     = "#57ab5a"
let s:blue      = "#6cb6ff"
let s:cyan      = "#96d0ff"
let s:purple    = "#b083f0"
let s:func      = "#dcbdfb"

" ------------------------------------------------------------------------------
" Editor UI
" ------------------------------------------------------------------------------
hi Normal           guifg=#adbac7 guibg=#22272e
hi EndOfBuffer      guifg=#22272e guibg=#22272e
hi CursorLine       guibg=#2d333b
hi CursorColumn     guibg=#2d333b
hi ColorColumn      guibg=#2d333b
hi CursorLineNr     guifg=#adbac7 guibg=#22272e gui=bold
hi LineNr           guifg=#545d68 guibg=#22272e
hi VertSplit        guifg=#373e47 guibg=#22272e
hi SignColumn       guifg=#545d68 guibg=#22272e
hi FoldColumn       guifg=#545d68 guibg=#22272e

hi Visual           guibg=#444c56
hi VisualNOS        guibg=#444c56
hi Search           guifg=#22272e guibg=#f69d50
hi IncSearch        guifg=#22272e guibg=#f47067
hi CurSearch        guifg=#22272e guibg=#f47067

hi StatusLine       guifg=#adbac7 guibg=#2d333b
hi StatusLineNC     guifg=#768390 guibg=#22272e
hi TabLine          guifg=#768390 guibg=#2d333b
hi TabLineSel       guifg=#adbac7 guibg=#22272e
hi TabLineFill      guibg=#22272e

hi Pmenu            guifg=#adbac7 guibg=#2d333b
hi PmenuSel         guifg=#adbac7 guibg=#444c56
hi PmenuSbar        guibg=#2d333b
hi PmenuThumb       guibg=#545d68

hi NormalFloat      guifg=#adbac7 guibg=#2d333b
hi FloatBorder      guifg=#373e47 guibg=#2d333b

hi MatchParen       guifg=#22272e guibg=#6cb6ff gui=bold

" ------------------------------------------------------------------------------
" Diff
" ------------------------------------------------------------------------------
hi DiffAdd          guifg=#57ab5a guibg=#22272e
hi DiffChange       guifg=#539bf5 guibg=#22272e
hi DiffDelete       guifg=#e5534b guibg=#22272e
hi DiffText         guifg=#6cb6ff guibg=#2d333b

" ------------------------------------------------------------------------------
" Git
" ------------------------------------------------------------------------------
hi GitGutterAdd     guifg=#57ab5a guibg=#22272e
hi GitGutterChange  guifg=#539bf5 guibg=#22272e
hi GitGutterDelete  guifg=#e5534b guibg=#22272e

" ------------------------------------------------------------------------------
" Diagnostics
" ------------------------------------------------------------------------------
hi DiagnosticError  guifg=#f47067
hi DiagnosticWarn   guifg=#d29922
hi DiagnosticInfo   guifg=#6cb6ff
hi DiagnosticHint   guifg=#57ab5a

" ------------------------------------------------------------------------------
" Syntax Base
" ------------------------------------------------------------------------------
hi Comment          guifg=#768390 gui=italic

hi Constant         guifg=#f69d50
hi String           guifg=#96d0ff
hi Character        guifg=#96d0ff
hi Number           guifg=#f69d50
hi Boolean          guifg=#f69d50
hi Float            guifg=#f69d50

hi Identifier       guifg=#adbac7
hi Function         guifg=#dcbdfb

hi Statement        guifg=#f47067
hi Conditional      guifg=#f47067
hi Repeat           guifg=#f47067
hi Label            guifg=#f47067
hi Operator         guifg=#6cb6ff
hi Keyword          guifg=#f47067
hi Exception        guifg=#f47067

hi PreProc          guifg=#b083f0
hi Include          guifg=#f47067
hi Define           guifg=#b083f0
hi Macro            guifg=#b083f0
hi PreCondit        guifg=#b083f0

hi Type             guifg=#6cb6ff
hi StorageClass     guifg=#6cb6ff
hi Structure        guifg=#6cb6ff
hi Typedef          guifg=#6cb6ff

hi Special          guifg=#b083f0
hi SpecialChar      guifg=#b083f0
hi Tag              guifg=#f47067
hi Delimiter        guifg=#adbac7
hi SpecialComment   guifg=#768390
hi Debug            guifg=#f47067

hi Underlined       gui=underline
hi Ignore           guifg=#545d68
hi Error            guifg=#f47067 gui=bold
hi Todo             guifg=#22272e guibg=#f69d50 gui=bold

" ------------------------------------------------------------------------------
" Folding
" ------------------------------------------------------------------------------
hi Folded           guifg=#768390 guibg=#2d333b

" ------------------------------------------------------------------------------
" Spelling
" ------------------------------------------------------------------------------
hi SpellBad         guisp=#f47067 gui=undercurl
hi SpellCap         guisp=#539bf5 gui=undercurl
hi SpellLocal       guisp=#b083f0 gui=undercurl
hi SpellRare        guisp=#f69d50 gui=undercurl

" ------------------------------------------------------------------------------
" Shell overrides (common issues)
" ------------------------------------------------------------------------------
hi shVariable       guifg=#adbac7
hi shDeref          guifg=#adbac7
hi shParameterExp   guifg=#adbac7
hi shCommandSub     guifg=#dcbdfb
hi shSubSh          guifg=#dcbdfb

" ------------------------------------------------------------------------------
" Markdown
" ------------------------------------------------------------------------------
hi markdownHeadingDelimiter guifg=#f47067
hi markdownCode              guifg=#96d0ff
hi markdownCodeBlock         guifg=#96d0ff
hi markdownLinkText          guifg=#6cb6ff gui=underline

" ==============================================================================
" End
" ==============================================================================
