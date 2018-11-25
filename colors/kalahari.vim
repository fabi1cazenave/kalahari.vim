"|
"| File    : ~/.vim/colors/kalahari.vim
"| File    : ~/.config/nvim/colors/kalahari.vim
"| Source  : https://github.com/fabi1cazenave/kalahari.vim
"| Licence : WTFPL
"|
"| High-contrast 'desert'-like theme with 256-color and 8-color modes.
"| Use `:set bg={dark,light}` to switch between dark/light variants.
"| Use `:let g:kalahari_ansi=1` to force the ANSI / 8-color mode.
"|

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="kalahari"

if has("autocmd") " auto-apply when updated
  autocmd! bufwritepost kalahari.vim colorscheme kalahari
endif


"|=============================================================================
"| Color Palettes
"|=============================================================================

let s:dark = ( &background ==# 'dark' )
let s:ansi = ( exists('g:kalahari_ansi') && g:kalahari_ansi ) ||
  \ !( has('gui_running') || has('termguicolors') || &t_Co == 256 )

" 8bit-to-24bit color converter {{{
" 3 color groups: 0-15 (ANSI), 16-87, 88-256
" (note that the ANSI colors are handled by the terminal emulator, not by Vim)
" https://jonasjacek.github.io/colors/
let s:rgb = [
\
\ '000000', '800000', '008000', '808000', '000080', '800080', '008080', 'c0c0c0',
\ '808080', 'ff0000', '00ff00', 'ffff00', '0000ff', 'ff00ff', '00ffff', 'ffffff',
\
\ '000000', '00005f', '000087', '0000af', '0000d7', '0000ff', '005f00', '005f5f',
\ '005f87', '005faf', '005fd7', '005fff', '008700', '00875f', '008787', '0087af',
\ '0087d7', '0087ff', '00af00', '00af5f', '00af87', '00afaf', '00afd7', '00afff',
\ '00d700', '00d75f', '00d787', '00d7af', '00d7d7', '00d7ff', '00ff00', '00ff5f',
\ '00ff87', '00ffaf', '00ffd7', '00ffff', '5f0000', '5f005f', '5f0087', '5f00af',
\ '5f00d7', '5f00ff', '5f5f00', '5f5f5f', '5f5f87', '5f5faf', '5f5fd7', '5f5fff',
\ '5f8700', '5f875f', '5f8787', '5f87af', '5f87d7', '5f87ff', '5faf00', '5faf5f',
\ '5faf87', '5fafaf', '5fafd7', '5fafff', '5fd700', '5fd75f', '5fd787', '5fd7af',
\ '5fd7d7', '5fd7ff', '5fff00', '5fff5f', '5fff87', '5fffaf', '5fffd7', '5fffff',
\
\ '870000', '87005f', '870087', '8700af', '8700d7', '8700ff', '875f00', '875f5f',
\ '875f87', '875faf', '875fd7', '875fff', '878700', '87875f', '878787', '8787af',
\ '8787d7', '8787ff', '87af00', '87af5f', '87af87', '87afaf', '87afd7', '87afff',
\ '87d700', '87d75f', '87d787', '87d7af', '87d7d7', '87d7ff', '87ff00', '87ff5f',
\ '87ff87', '87ffaf', '87ffd7', '87ffff', 'af0000', 'af005f', 'af0087', 'af00af',
\ 'af00d7', 'af00ff', 'af5f00', 'af5f5f', 'af5f87', 'af5faf', 'af5fd7', 'af5fff',
\ 'af8700', 'af875f', 'af8787', 'af87af', 'af87d7', 'af87ff', 'afaf00', 'afaf5f',
\ 'afaf87', 'afafaf', 'afafd7', 'afafff', 'afd700', 'afd75f', 'afd787', 'afd7af',
\ 'afd7d7', 'afd7ff', 'afff00', 'afff5f', 'afff87', 'afffaf', 'afffd7', 'afffff',
\ 'd70000', 'd7005f', 'd70087', 'd700af', 'd700d7', 'd700ff', 'd75f00', 'd75f5f',
\ 'd75f87', 'd75faf', 'd75fd7', 'd75fff', 'd78700', 'd7875f', 'd78787', 'd787af',
\ 'd787d7', 'd787ff', 'd7af00', 'd7af5f', 'd7af87', 'd7afaf', 'd7afd7', 'd7afff',
\ 'd7d700', 'd7d75f', 'd7d787', 'd7d7af', 'd7d7d7', 'd7d7ff', 'd7ff00', 'd7ff5f',
\ 'd7ff87', 'd7ffaf', 'd7ffd7', 'd7ffff', 'ff0000', 'ff005f', 'ff0087', 'ff00af',
\ 'ff00d7', 'ff00ff', 'ff5f00', 'ff5f5f', 'ff5f87', 'ff5faf', 'ff5fd7', 'ff5fff',
\ 'ff8700', 'ff875f', 'ff8787', 'ff87af', 'ff87d7', 'ff87ff', 'ffaf00', 'ffaf5f',
\ 'ffaf87', 'ffafaf', 'ffafd7', 'ffafff', 'ffd700', 'ffd75f', 'ffd787', 'ffd7af',
\ 'ffd7d7', 'ffd7ff', 'ffff00', 'ffff5f', 'ffff87', 'ffffaf', 'ffffd7', 'ffffff',
\ '080808', '121212', '1c1c1c', '262626', '303030', '3a3a3a', '444444', '4e4e4e',
\ '585858', '626262', '6c6c6c', '767676', '808080', '8a8a8a', '949494', '9e9e9e',
\ 'a8a8a8', 'b2b2b2', 'bcbcbc', 'c6c6c6', 'd0d0d0', 'dadada', 'e4e4e4', 'eeeeee',
\]

function! <SID>HL(group, fg, bg, attr)
  let l:bg = ''
  if a:bg >= 16
    let l:bg = ' ctermbg=' . a:bg . ' guibg=#' . s:rgb[a:bg]
  elseif a:bg >= 0
    let l:bg = ' ctermbg=' . a:bg
  endif

  let l:fg = ''
  if a:fg >= 16
    let l:fg = ' ctermfg=' . a:fg . ' guifg=#' . s:rgb[a:fg]
  elseif a:fg >= 0
    let l:fg = ' ctermfg=' . a:fg
  endif

  let l:attr = ''
  if a:attr != ''
    let l:attr = ' gui=' . a:attr . ' cterm=' . a:attr
  endif

  let l:exec = l:fg . l:bg . l:attr
  if l:exec != ''
    exec 'hi ' . a:group . l:exec
  endif
endfunction
" }}}

" 256-color palette, adapted from 'desert256' {{{
if !s:ansi

  " grey scale {{{
  let s:grey_0   = 16  " #000000
  let s:grey_4   = 232 " #080808 -- equivalent to `0` (ANSI), do not use
  let s:grey_8   = 233 " #121212
  let s:grey_12  = 234 " #1c1c1c
  let s:grey_16  = 235 " #262626
  let s:grey_20  = 236 " #303030
  let s:grey_24  = 237 " #3a3a3a
  let s:grey_28  = 238 " #444444
  let s:grey_32  = 239 " #4e4e4e
  let s:grey_36  = 240 " #585858
  let s:grey_40  = 241 " #626262
  let s:grey_44  = 242 " #6c6c6c
  let s:grey_48  = 243 " #767676
  let s:grey_52  = 244 " #808080
  let s:grey_56  = 245 " #8a8a8a
  let s:grey_60  = 246 " #949494
  let s:grey_64  = 247 " #9e9e9e
  let s:grey_68  = 248 " #a8a8a8
  let s:grey_72  = 249 " #b2b2b2
  let s:grey_76  = 250 " #bcbcbc
  let s:grey_80  = 251 " #c6c6c6
  let s:grey_84  = 252 " #d0d0d0
  let s:grey_88  = 253 " #dadada
  let s:grey_92  = 254 " #e4e4e4
  let s:grey_96  = 255 " #eeeeee
  let s:grey_100 = 231 " #ffffff
  " }}}

  " default text & separators {{{
  " low number means high contrast, high number means low contrast
  if s:dark
    let s:fg_1 = s:grey_92 " default text
    let s:fg_2 = s:grey_88
    let s:fg_3 = s:grey_76
    let s:fg_4 = s:grey_64
    let s:fg_5 = s:grey_36
    let s:bg_1 = s:grey_8  " default background
    let s:bg_2 = s:grey_12
    let s:bg_3 = s:grey_20
    let s:bg_4 = s:grey_24
    let s:bg_5 = s:grey_36
  else
    let s:fg_1 = s:grey_16 " default text
    let s:fg_2 = s:grey_20
    let s:fg_3 = s:grey_32
    let s:fg_4 = s:grey_44
    let s:fg_5 = s:grey_72
    let s:bg_1 = s:grey_96 " default background
    let s:bg_2 = s:grey_92
    let s:bg_3 = s:grey_88
    let s:bg_4 = s:grey_84
    let s:bg_5 = s:grey_72
  endif
  " }}}

  " UI palette {{{
  if s:dark
    let s:NonText    = 152 " LightCyan3
    let s:ModeMsg    = 39  " DeepSkyBlue1
    let s:Question   = 48  " SpringGreen1
    let s:SpecialKey = 111 " SkyBlue2
    let s:Search_bg  = 28  " Green4
    let s:Visual_bg  = 68  " SteelBlue3
    let s:WarningMsg = 209 " Salmon1
  else
    let s:NonText    = 36  " DarkCyan
    let s:ModeMsg    = 21  " Blue1
    let s:Question   = 34  " Green3
    let s:SpecialKey = 68  " SteelBlue3
    let s:Search_bg  = 40  " Green3
    let s:Visual_bg  = 75  " SteelBlue1
    let s:WarningMsg = 130 " DarkOrange3
  endif
  let s:Cursor       = 68  " SteelBlue3
  let s:Cursor_bg    = 222 " LightGoldenRod2
  " }}}

  " syntax palette {{{
  if s:dark
    let s:Constant   = 217 " LightPink1
    let s:Identifier = 120 " LightGreen
    let s:Statement  = 39  " DeepSkyBlue1
    let s:PreProc    = 167 " IndianRed
    let s:Type       = 178 " Gold3
    let s:Type       = 143 " DarkKhaki
    let s:Special    = 223 " NavajoWhite1
    let s:Special    = 214 " Orange1
    let s:Underlined = 81  " SteelBlue1
  else
    let s:Constant   = 168 " HotPink3
    let s:Identifier = 29  " SpringGreen4
    let s:Statement  = 27  " DodgerBlue2
    let s:PreProc    = 124 " Red3
    let s:Type       = 172 " Orange3
    let s:Type       = 142 " Gold2
    let s:Special    = 173 " LightSalmon3
    let s:Special    = 166 " DarkOrange3
    let s:Underlined = 21  " Blue1
  endif
  let s:Comment      = s:fg_4
  let s:Ignore       = s:fg_5
  let s:Error        = 15
  let s:Error_bg     = 9
  let s:Todo         = 255
  let s:Todo_bg      = 167
  " }}}

"}}}

" ANSI color palette (= default terminal colors) {{{
else

  " default text & separators {{{
  let s:fg_1 = 15
  let s:fg_2 = 15
  let s:fg_3 = 7
  let s:fg_4 = 7
  let s:fg_5 = 8
  let s:bg_1 = 0
  let s:bg_2 = 0
  let s:bg_3 = 8
  let s:bg_4 = 8
  let s:bg_5 = 8
  " }}}

  " UI palette {{{
  let s:NonText      = 14
  let s:ModeMsg      = 4
  let s:Question     = 2
  let s:SpecialKey   = 2
  let s:Search_bg    = 2
  let s:Visual_bg    = 12
  let s:WarningMsg   = 9
  let s:Cursor       = 6
  let s:Cursor_bg    = 11
  " }}}

  " syntax palette {{{
  if s:dark
    let s:Constant   = 9
    let s:Identifier = 10
    let s:Statement  = 12
    let s:PreProc    = 13
    let s:Type       = 3
    let s:Special    = 11
    let s:Underlined = 6
  else
    let s:Constant   = 9
    let s:Identifier = 2
    let s:Statement  = 12
    let s:PreProc    = 5
    let s:Type       = 3
    let s:Special    = 1
    let s:Underlined = 4
  endif
  let s:Comment      = s:fg_4
  let s:Ignore       = s:fg_5
  let s:Error        = 15
  let s:Error_bg     = 9
  let s:Todo         = 15
  let s:Todo_bg      = 9
  " }}}

endif
"}}}


"|=============================================================================
"| Highlight Groups
"|=============================================================================

" common UI groups, see `:help highlight-groups` {{{
call <sid>HL('ColorColumn',     -1,            s:bg_2,        'none')
call <sid>HL('Conceal',         -1,            -1,            '')
call <sid>HL('Cursor',          s:Cursor,      s:Cursor_bg,   '')
call <sid>HL('CursorIM',        -1,            -1,            '')
call <sid>HL('CursorColumn',    -1,            s:bg_3,        '')
call <sid>HL('CursorLine',      -1,            s:bg_3,        'none')
"call <sid>HL('Directory',       159,           -1,            '')
"call <sid>HL('DiffAdd',         -1,            4,             '')
"call <sid>HL('DiffChange',      -1,            5,             '')
"call <sid>HL('DiffDelete',      12,            6,             '')
"call <sid>HL('DiffText',        -1,            9,             'bold')
call <sid>HL('EndOfBuffer',     -1,            -1,            '') " same as NonText
call <sid>HL('TermCursor',      s:Cursor,      s:Cursor_bg,   '')
call <sid>HL('TermCursorNC',    s:Cursor,      s:Cursor_bg,   '')
call <sid>HL('ErrorMsg',        s:Error,       s:Error_bg,    '')
call <sid>HL('VertSplit',       s:fg_5,        s:bg_4,        'none')
call <sid>HL('Folded',          s:fg_4,        s:bg_3,        '')
call <sid>HL('FoldColumn',      -1,            s:bg_3,        '')
call <sid>HL('SignColumn',      s:fg_3,        s:bg_3,        '')
call <sid>HL('IncSearch',       -1,            -1,            '')
call <sid>HL('Substitute',      -1,            -1,            '')
call <sid>HL('LineNr',          s:fg_5,        -1,            '')
call <sid>HL('CursorLineNr',    s:fg_5,        -1,            '')
call <sid>HL('MatchParen',      -1,            s:Visual_bg,   '')
call <sid>HL('ModeMsg',         s:ModeMsg,     -1,            'bold')
call <sid>HL('MsgSeparator',    -1,            -1,            '')
call <sid>HL('MoreMsg',         s:Question,    -1,            '')
call <sid>HL('NonText',         s:NonText,     s:bg_2,        'bold')
call <sid>HL('Normal',          s:fg_1,        s:bg_1,        '')
call <sid>HL('NormalNC',        -1,            -1,            '')
call <sid>HL('Pmenu',           s:fg_2,        s:bg_4,        '')
call <sid>HL('PmenuSel',        s:fg_2,        s:bg_5,        'bold')
call <sid>HL('PmenuSbar',       -1,            s:bg_3,        '')
call <sid>HL('PmenuThumb',      -1,            s:bg_4,        '')
call <sid>HL('Question',        s:Question,    -1,            'bold')
call <sid>HL('QuickFixLine',    -1,            -1,            '')
call <sid>HL('Search',          s:fg_1,        s:Search_bg,   '')
call <sid>HL('SpecialKey',      s:SpecialKey,  -1,            '')
call <sid>HL('SpellBad',        s:fg_3,        s:bg_3,        'undercurl')
"call <sid>HL('SpellCap',        -1,            12,            '')
"call <sid>HL('SpellLocal',      -1,            14,            '')
"call <sid>HL('SpellRare',       -1,            13,            '')
call <sid>HL('StatusLine',      s:fg_4,        s:bg_1,        'reverse')
call <sid>HL('StatusLineNC',    s:fg_4,        s:bg_4,        'none')
call <sid>HL('TabLine',         s:fg_4,        s:bg_4,        'underline')
call <sid>HL('TabLineFill',     -1,            s:bg_4,        'none')
call <sid>HL('TabLineSel',      s:fg_1,        s:bg_1,        'bold')
call <sid>HL('Title',           s:fg_1,        -1,            'bold')
call <sid>HL('Visual',          s:fg_1,        s:Visual_bg,   '')
call <sid>HL('VisualNOS',       -1,            -1,            'bold,underline')
call <sid>HL('WarningMsg',      s:WarningMsg,  -1,            '')
call <sid>HL('Whitespace',      s:fg_4,        -1,            '')
call <sid>HL('WildMenu',        -1,            s:Visual_bg,   'bold')
"}}}

" common syntax groups, see `:help group-name` {{{
call <sid>HL('Comment',         s:Comment,     -1,            'italic')
call <sid>HL('Constant',        s:Constant,    -1,            '')
call <sid>HL('Boolean',         -1,            -1,            '')
call <sid>HL('Character',       -1,            -1,            '')
call <sid>HL('Float',           -1,            -1,            '')
call <sid>HL('Number',          -1,            -1,            '')
call <sid>HL('String',          -1,            -1,            '')
call <sid>HL('Identifier',      s:Identifier,  -1,            '')
call <sid>HL('Function',        -1,            -1,            '')
call <sid>HL('Statement',       s:Statement,   -1,            'bold')
call <sid>HL('Conditional',     -1,            -1,            '')
call <sid>HL('Repeat',          -1,            -1,            '')
call <sid>HL('Label',           -1,            -1,            '')
call <sid>HL('Operator',        -1,            -1,            '')
call <sid>HL('Keyword',         -1,            -1,            '')
call <sid>HL('Exception',       -1,            -1,            '')
call <sid>HL('PreProc',         s:PreProc,     -1,            '')
call <sid>HL('Include',         -1,            -1,            '')
call <sid>HL('Defile',          -1,            -1,            '')
call <sid>HL('Macro',           -1,            -1,            '')
call <sid>HL('PreCondit',       -1,            -1,            '')
call <sid>HL('Type',            s:Type,        -1,            '')
call <sid>HL('StorageClass',    -1,            -1,            '')
call <sid>HL('Structure',       -1,            -1,            '')
call <sid>HL('Typedef',         -1,            -1,            '')
call <sid>HL('Special',         s:Special,     -1,            '')
call <sid>HL('SpecialChar',     -1,            -1,            '')
call <sid>HL('SpecialComment',  -1,            -1,            'italic')
call <sid>HL('Tag',             -1,            -1,            '')
call <sid>HL('Delimiter',       -1,            -1,            '')
call <sid>HL('Debug',           -1,            -1,            '')
call <sid>HL('Underlined',      s:Underlined,  -1,            'underline')
call <sid>HL('Ignore',          s:Ignore,      -1,            '')
call <sid>HL('Error',           s:Error,       s:Error_bg,    '')
call <sid>HL('Todo',            s:Todo,        s:Todo_bg,     '')
"}}}

" Vim highlighting {{{
call <sid>HL('vimCommand',      s:Statement,   -1, 'bold')
call <sid>HL('vimCommentTitle', s:Comment,     -1, 'bold,italic')
call <sid>HL('vimFunction',     s:Identifier,  -1, '')
call <sid>HL('vimFuncName',     s:Identifier,  -1, '')
call <sid>HL('vimHighlight',    s:Statement,   -1, '')
call <sid>HL('vimLineComment',  s:Comment,     -1, 'italic')
call <sid>HL('vimParenSep',     s:fg_2,        -1, '')
call <sid>HL('vimSep',          -1,            -1, '')
call <sid>HL('vimUserFunc',     s:Identifier,  -1, '')
call <sid>HL('vimVar',          s:Identifier,  -1, '')
" }}}

" JavaScript highlighting {{{
call <sid>HL('javaScriptBraces',       -1,            -1, '')
call <sid>HL('javaScriptFunction',     s:Statement,   -1, '')
call <sid>HL('javaScriptIdentifier',   s:Identifier,  -1, '')
call <sid>HL('javaScriptNull',         s:Constant,    -1, '')
call <sid>HL('javaScriptNumber',       s:Constant,    -1, '')
call <sid>HL('javaScriptRequire',      s:Statement,   -1, '')
call <sid>HL('javaScriptReserved',     s:Statement,   -1, '')
" https://github.com/pangloss/vim-javascript
call <sid>HL('jsArrowFunction',        s:Statement,   -1, 'bold')
call <sid>HL('jsBraces',               s:fg_1,        -1, '')
call <sid>HL('jsClassBraces',          s:fg_1,        -1, '')
call <sid>HL('jsClassKeywords',        s:Special,     -1, 'bold')
call <sid>HL('jsDocParam',             -1,            -1, '')
call <sid>HL('jsDocTags',              -1,            -1, '')
call <sid>HL('jsFuncBraces',           s:fg_1,        -1, '')
call <sid>HL('jsFuncCall',             s:Statement,   -1, '')
call <sid>HL('jsFuncParens',           s:fg_2,        -1, '')
call <sid>HL('jsFunction',             s:Statement,   -1, '')
call <sid>HL('jsGlobalObjects',        s:Identifier,  -1, 'bold')
call <sid>HL('jsModuleWords',          s:PreProc,     -1, '')
call <sid>HL('jsModules',              s:PreProc,     -1, '')
call <sid>HL('jsNoise',                s:fg_4,        -1, '')
call <sid>HL('jsNull',                 s:Constant,    -1, '')
call <sid>HL('jsOperator',             s:Statement,   -1, '')
call <sid>HL('jsParens',               s:fg_1,        -1, '')
call <sid>HL('jsStorageClass',         s:Type,        -1, '')
call <sid>HL('jsTemplateBraces',       -1,            -1, '')
call <sid>HL('jsTemplateVar',          -1,            -1, '')
call <sid>HL('jsThis',                 s:Special,     -1, '')
call <sid>HL('jsUndefined',            s:Special,     -1, '')
call <sid>HL('jsObjectValue',          s:Constant,    -1, '')
call <sid>HL('jsObjectKey',            s:Identifier,  -1, '')
call <sid>HL('jsReturn',               s:Statement,   -1, '')
" https://github.com/othree/yajs.vim
call <sid>HL('javascriptArrowFunc',    s:Statement,   -1, 'bold')
call <sid>HL('javascriptClassExtends', s:Statement,   -1, '')
call <sid>HL('javascriptClassKeyword', s:Statement,   -1, '')
call <sid>HL('javascriptDocNotation',  -1,            -1, '')
call <sid>HL('javascriptDocParamName', -1,            -1, '')
call <sid>HL('javascriptDocTags',      -1,            -1, '')
call <sid>HL('javascriptEndColons',    s:Statement,   -1, '')
call <sid>HL('javascriptExport',       s:PreProc,     -1, '')
call <sid>HL('javascriptFuncArg',      -1,            -1, '')
call <sid>HL('javascriptFuncKeyword',  s:Statement,   -1, '')
call <sid>HL('javascriptIdentifier',   s:Identifier,  -1, '')
call <sid>HL('javascriptImport',       s:PreProc,     -1, '')
call <sid>HL('javascriptObjectLabel',  s:Identifier,  -1, '')
call <sid>HL('javascriptOpSymbol',     -1,            -1, '')
call <sid>HL('javascriptOpSymbols',    -1,            -1, '')
call <sid>HL('javascriptPropertyName', s:Identifier,  -1, '')
call <sid>HL('javascriptTemplateSB',   -1,            -1, '')
call <sid>HL('javascriptVariable',     s:Statement,   -1, '')
" }}}


"|=============================================================================
"| Public API
"|=============================================================================

function! kalahari#highlight(group, fg, bg, attr)
  call <sid>HL(a:group, a:fg, a:bg, a:attr)
endfunction

" vim: set fdm=marker fmr={{{,}}} fdl=0:
