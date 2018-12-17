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
let s:ansi = ( ( exists('g:kalahari_ansi') && g:kalahari_ansi ) ||
  \ !( &t_Co == 256 || has('termguicolors') ) ) && !has('gui_running')
let s:mode = 2 * !s:ansi + !s:dark

" Vim users must allow italics explicitly
let s:italic = has('nvim') || has('gui_running') ||
  \ (exists('g:kalahari_italic') && g:kalahari_italic)

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
  if a:attr != '' && (s:italic || a:attr != 'italic')
    let l:attr = ' cterm=' . a:attr . ' gui=' . a:attr
  endif

  let l:exec = l:fg . l:bg . l:attr
  if l:exec != ''
    execute 'hi ' . a:group . l:exec
  endif
endfunction
" }}}

" Palette: 16 & 256-color modes, light & dark variants {{{
" 1st group = default text & separators (higher number means lower contrast)
" 2nd group = UI highlights     -- see `:help highlight-groups`
" 3nd group = syntax highlights -- see `:help group-name`
" +------------+------------+------------+
" |            |  16-color  | 256-color  |
" | name       | dark,light | dark,light |
" +------------+------------+------------+
let s:palette = {
\ 'fg_1'       : [  15,  15,    254, 235 ],
\ 'fg_2'       : [  15,  15,    253, 236 ],
\ 'fg_3'       : [   7,   7,    250, 239 ],
\ 'fg_4'       : [   7,   7,    247, 242 ],
\ 'fg_5'       : [   8,   8,    240, 249 ],
\ 'bg_5'       : [   8,   8,    240, 249 ],
\ 'bg_4'       : [   8,   8,    237, 252 ],
\ 'bg_3'       : [   8,   8,    235, 253 ],
\ 'bg_2'       : [   0,   0,    234, 254 ],
\ 'bg_1'       : [   0,   0,    233, 255 ],
\
\ 'NonText'    : [  14,  14,    152,  36 ],
\ 'ModeMsg'    : [   4,   4,     39,  21 ],
\ 'Question'   : [   2,   2,     48,  34 ],
\ 'SpecialKey' : [   2,   2,    111,  68 ],
\ 'Search_bg'  : [   2,   2,     28,  40 ],
\ 'Visual_bg'  : [  12,  12,     68,  75 ],
\ 'WarningMsg' : [   9,   9,    209, 130 ],
\ 'Cursor'     : [   6,   6,     68,  68 ],
\ 'Cursor_bg'  : [  11,  11,    222, 222 ],
\
\ 'Constant'   : [   9,   9,    217, 168 ],
\ 'Identifier' : [  10,  10,    120,  29 ],
\ 'Statement'  : [  12,  12,     39,  27 ],
\ 'PreProc'    : [  13,  13,    167, 124 ],
\ 'Type'       : [   3,   3,    178, 142 ],
\ 'Special'    : [  11,  11,    223, 166 ],
\ 'Underlined' : [   6,   6,     81,  21 ],
\ 'Comment'    : [   7,   7,    247, 242 ],
\ 'Ignore'     : [   8,   8,    240, 249 ],
\ 'Error'      : [  15,  15,     15,  15 ],
\ 'Error_bg'   : [   9,   9,      9,   9 ],
\ 'Todo'       : [  15,  15,    255, 255 ],
\ 'Todo_bg'    : [   9,   9,    167, 167 ],
\} " }}}

" select the proper color mode
let s:P = {}
for [key, val] in items(s:palette)
  let s:P[key] = (!s:ansi || &t_Co > 8) ? val[s:mode] : val[s:mode] % 8
endfor

" partial override if `g:kalahari_palette` is defined
if exists('g:kalahari_palette')
  for [key, val] in items(g:kalahari_palette)
    if type(val) <= 1 " number or string
      let s:P[key] = val
    elseif type(val) == 3 " array
      let s:P[key] = val[ s:mode % len(val) ]
    endif
  endfor
endif

"|=============================================================================
"| Highlight Groups: user interface
"|=============================================================================

" common UI groups, see `:help highlight-groups` {{{
call <sid>HL('ColorColumn',     -1,              s:P.bg_2,        'none')
call <sid>HL('Conceal',         -1,              -1,              '')
call <sid>HL('Cursor',          s:P.Cursor,      s:P.Cursor_bg,   '')
call <sid>HL('CursorIM',        -1,              -1,              '')
call <sid>HL('CursorColumn',    -1,              s:P.bg_3,        '')
call <sid>HL('CursorLine',      -1,              s:P.bg_3,        'none')
call <sid>HL('Directory',       s:P.SpecialKey,  -1,              '')
"call <sid>HL('DiffAdd',         -1,              4,               '')
"call <sid>HL('DiffChange',      -1,              5,               '')
"call <sid>HL('DiffDelete',      12,              6,               '')
"call <sid>HL('DiffText',        -1,              9,               'bold')
call <sid>HL('EndOfBuffer',     -1,              -1,              '') " same as NonText
call <sid>HL('TermCursor',      s:P.Cursor,      s:P.Cursor_bg,   '')
call <sid>HL('TermCursorNC',    s:P.Cursor,      s:P.Cursor_bg,   '')
call <sid>HL('ErrorMsg',        s:P.Error,       s:P.Error_bg,    '')
call <sid>HL('VertSplit',       s:P.fg_5,        s:P.bg_4,        'none')
call <sid>HL('Folded',          s:P.fg_4,        s:P.bg_3,        '')
call <sid>HL('FoldColumn',      -1,              s:P.bg_3,        '')
call <sid>HL('SignColumn',      s:P.fg_3,        s:P.bg_3,        '')
call <sid>HL('IncSearch',       -1,              -1,              '')
call <sid>HL('Substitute',      -1,              -1,              '')
call <sid>HL('LineNr',          s:P.fg_5,        -1,              '')
call <sid>HL('CursorLineNr',    s:P.fg_5,        -1,              '')
call <sid>HL('MatchParen',      -1,              s:P.Visual_bg,   '')
call <sid>HL('ModeMsg',         s:P.ModeMsg,     -1,              'bold')
call <sid>HL('MsgSeparator',    -1,              -1,              '')
call <sid>HL('MoreMsg',         s:P.Question,    -1,              '')
call <sid>HL('NonText',         s:P.NonText,     s:P.bg_2,        'bold')
call <sid>HL('Normal',          s:P.fg_1,        s:P.bg_1,        '')
call <sid>HL('NormalNC',        -1,              -1,              '')
call <sid>HL('Pmenu',           s:P.fg_2,        s:P.bg_4,        '')
call <sid>HL('PmenuSel',        s:P.fg_2,        s:P.bg_5,        'bold')
call <sid>HL('PmenuSbar',       -1,              s:P.bg_3,        '')
call <sid>HL('PmenuThumb',      -1,              s:P.bg_4,        '')
call <sid>HL('Question',        s:P.Question,    -1,              'bold')
call <sid>HL('QuickFixLine',    -1,              -1,              '')
call <sid>HL('Search',          s:P.fg_1,        s:P.Search_bg,   '')
call <sid>HL('SpecialKey',      s:P.SpecialKey,  -1,              '')
call <sid>HL('SpellBad',        s:P.fg_3,        s:P.bg_3,        'undercurl')
"call <sid>HL('SpellCap',        -1,              12,            '')
"call <sid>HL('SpellLocal',      -1,              14,            '')
"call <sid>HL('SpellRare',       -1,              13,            '')
call <sid>HL('StatusLine',      s:P.fg_4,        s:P.bg_1,        'reverse')
call <sid>HL('StatusLineNC',    s:P.fg_4,        s:P.bg_4,        'none')
call <sid>HL('TabLine',         s:P.fg_4,        s:P.bg_4,        'underline')
call <sid>HL('TabLineFill',     -1,              s:P.bg_4,        'none')
call <sid>HL('TabLineSel',      s:P.fg_1,        s:P.bg_1,        'bold')
call <sid>HL('Title',           s:P.fg_1,        -1,              'bold')
call <sid>HL('Visual',          s:P.fg_1,        s:P.Visual_bg,   '')
call <sid>HL('VisualNOS',       -1,              -1,              'bold,underline')
call <sid>HL('WarningMsg',      s:P.WarningMsg,  -1,              '')
call <sid>HL('Whitespace',      s:P.fg_4,        -1,              '')
call <sid>HL('WildMenu',        -1,              s:P.Visual_bg,   'bold')
"}}}

" Startify {{{
call <sid>HL('StartifyBracket',          -1,              -1, '')
call <sid>HL('StartifyFile',             -1,              -1, '')
call <sid>HL('StartifyFooter',           -1,              -1, '')
call <sid>HL('StartifyHeader',           -1,              -1, '')
call <sid>HL('StartifyNumber',           -1,              -1, '')
call <sid>HL('StartifyPath',             -1,              -1, '')
call <sid>HL('StartifySection',          -1,              -1, '')
call <sid>HL('StartifySelect',           -1,              -1, '')
call <sid>HL('StartifySlash',            s:P.fg_5,        -1, '')
call <sid>HL('StartifySpecial',          s:P.Type,        -1, '')
call <sid>HL('StartifyVar',              -1,              -1, '')
" }}}

"|=============================================================================
"| Highlight Groups: language syntax
"|=============================================================================

" common syntax groups, see `:help group-name` {{{
call <sid>HL('Comment',         s:P.Comment,     -1,              'italic')
call <sid>HL('Constant',        s:P.Constant,    -1,              '')
call <sid>HL('Boolean',         -1,              -1,              '')
call <sid>HL('Character',       -1,              -1,              '')
call <sid>HL('Float',           -1,              -1,              '')
call <sid>HL('Number',          -1,              -1,              '')
call <sid>HL('String',          -1,              -1,              '')
call <sid>HL('Identifier',      s:P.Identifier,  -1,              '')
call <sid>HL('Function',        -1,              -1,              '')
call <sid>HL('Statement',       s:P.Statement,   -1,              'bold')
call <sid>HL('Conditional',     -1,              -1,              '')
call <sid>HL('Repeat',          -1,              -1,              '')
call <sid>HL('Label',           -1,              -1,              '')
call <sid>HL('Operator',        -1,              -1,              '')
call <sid>HL('Keyword',         -1,              -1,              '')
call <sid>HL('Exception',       -1,              -1,              '')
call <sid>HL('PreProc',         s:P.PreProc,     -1,              '')
call <sid>HL('Include',         -1,              -1,              '')
call <sid>HL('Defile',          -1,              -1,              '')
call <sid>HL('Macro',           -1,              -1,              '')
call <sid>HL('PreCondit',       -1,              -1,              '')
call <sid>HL('Type',            s:P.Type,        -1,              '')
call <sid>HL('StorageClass',    -1,              -1,              '')
call <sid>HL('Structure',       -1,              -1,              '')
call <sid>HL('Typedef',         -1,              -1,              '')
call <sid>HL('Special',         s:P.Special,     -1,              '')
call <sid>HL('SpecialChar',     -1,              -1,              '')
call <sid>HL('SpecialComment',  s:P.Special,     -1,              'italic')
call <sid>HL('Tag',             -1,              -1,              '')
call <sid>HL('Delimiter',       -1,              -1,              '')
call <sid>HL('Debug',           -1,              -1,              '')
call <sid>HL('Underlined',      s:P.Underlined,  -1,              'underline')
call <sid>HL('Ignore',          s:P.Ignore,      -1,              '')
call <sid>HL('Error',           s:P.Error,       s:P.Error_bg,    '')
call <sid>HL('Todo',            s:P.Todo,        s:P.Todo_bg,     '')
"}}}

" Vim highlighting {{{
call <sid>HL('vimCommand',               s:P.Statement,   -1,  'bold')
call <sid>HL('vimCommentTitle',          s:P.Comment,     -1,  'bold,italic')
call <sid>HL('vimFunction',              s:P.Identifier,  -1,  '')
call <sid>HL('vimFuncName',              s:P.Identifier,  -1,  '')
call <sid>HL('vimHighlight',             s:P.Statement,   -1,  '')
call <sid>HL('vimLineComment',           s:P.Comment,     -1,  'italic')
call <sid>HL('vimParenSep',              s:P.fg_2,        -1,  '')
call <sid>HL('vimSep',                   -1,              -1,  '')
call <sid>HL('vimUserFunc',              s:P.Identifier,  -1,  '')
call <sid>HL('vimVar',                   s:P.Identifier,  -1,  '')
" }}}

" JavaScript highlighting {{{
call <sid>HL('javaScriptBraces',         -1,              -1,  '')
call <sid>HL('javaScriptFunction',       s:P.Statement,   -1,  '')
call <sid>HL('javaScriptIdentifier',     s:P.Identifier,  -1,  '')
call <sid>HL('javaScriptNull',           s:P.Constant,    -1,  '')
call <sid>HL('javaScriptNumber',         s:P.Constant,    -1,  '')
call <sid>HL('javaScriptRequire',        s:P.Statement,   -1,  '')
call <sid>HL('javaScriptReserved',       s:P.Statement,   -1,  '')
" https:P.//github.com/pangloss/vim-javascript
call <sid>HL('jsArrowFunction',          s:P.Statement,   -1,  'bold')
call <sid>HL('jsBraces',                 s:P.fg_1,        -1,  '')
call <sid>HL('jsClassBraces',            s:P.fg_1,        -1,  '')
call <sid>HL('jsClassKeywords',          s:P.Special,     -1,  'bold')
call <sid>HL('jsDocParam',               -1,              -1,  '')
call <sid>HL('jsDocTags',                -1,              -1,  '')
call <sid>HL('jsFuncBraces',             s:P.fg_1,        -1,  '')
call <sid>HL('jsFuncCall',               s:P.Statement,   -1,  '')
call <sid>HL('jsFuncParens',             s:P.fg_2,        -1,  '')
call <sid>HL('jsFunction',               s:P.Statement,   -1,  '')
call <sid>HL('jsGlobalObjects',          s:P.Identifier,  -1,  'bold')
call <sid>HL('jsModuleWords',            s:P.PreProc,     -1,  '')
call <sid>HL('jsModules',                s:P.PreProc,     -1,  '')
call <sid>HL('jsNoise',                  s:P.fg_4,        -1,  '')
call <sid>HL('jsNull',                   s:P.Constant,    -1,  '')
call <sid>HL('jsOperator',               s:P.Statement,   -1,  '')
call <sid>HL('jsParens',                 s:P.fg_1,        -1,  '')
call <sid>HL('jsStorageClass',           s:P.Type,        -1,  '')
call <sid>HL('jsTemplateBraces',         -1,              -1,  '')
call <sid>HL('jsTemplateVar',            -1,              -1,  '')
call <sid>HL('jsThis',                   s:P.Special,     -1,  '')
call <sid>HL('jsUndefined',              s:P.Special,     -1,  '')
call <sid>HL('jsObjectValue',            s:P.Constant,    -1,  '')
call <sid>HL('jsObjectKey',              s:P.Identifier,  -1,  '')
call <sid>HL('jsReturn',                 s:P.Statement,   -1,  '')
" https:P.//github.com/othree/yajs.vim
call <sid>HL('javascriptArrowFunc',      s:P.Statement,   -1,  'bold')
call <sid>HL('javascriptClassExtends',   s:P.Statement,   -1,  '')
call <sid>HL('javascriptClassKeyword',   s:P.Statement,   -1,  '')
call <sid>HL('javascriptDocNotation',    -1,              -1,  '')
call <sid>HL('javascriptDocParamName',   -1,              -1,  '')
call <sid>HL('javascriptDocTags',        -1,              -1,  '')
call <sid>HL('javascriptEndColons',      s:P.Statement,   -1,  '')
call <sid>HL('javascriptExport',         s:P.PreProc,     -1,  '')
call <sid>HL('javascriptFuncArg',        -1,              -1,  '')
call <sid>HL('javascriptFuncKeyword',    s:P.Statement,   -1,  '')
call <sid>HL('javascriptIdentifier',     s:P.Identifier,  -1,  '')
call <sid>HL('javascriptImport',         s:P.PreProc,     -1,  '')
call <sid>HL('javascriptObjectLabel',    s:P.Identifier,  -1,  '')
call <sid>HL('javascriptOpSymbol',       -1,              -1,  '')
call <sid>HL('javascriptOpSymbols',      -1,              -1,  '')
call <sid>HL('javascriptPropertyName',   s:P.Identifier,  -1,  '')
call <sid>HL('javascriptTemplateSB',     -1,              -1,  '')
call <sid>HL('javascriptVariable',       s:P.Statement,   -1,  '')
" }}}

"|=============================================================================
"| Highlight Groups: custom definitions
"|=============================================================================

" partial override if `g:kalahari_groups` is defined
if exists('g:kalahari_groups')
  for [group, fg, bg, attr] in g:kalahari_groups
    let fg = get(s:P, fg, fg != '' ? str2nr(fg) : -1)
    let bg = get(s:P, bg, bg != '' ? str2nr(bg) : -1)
    call <sid>HL(group, fg, bg, attr)
  endfor
endif

" required by Vim 7 to switch properly between 'dark' & 'light'
if s:dark
  set background=dark
endif

" vim: set fdm=marker fmr={{{,}}} fdl=0:
