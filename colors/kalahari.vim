"|
"| File    : ~/.vim/colors/kalahari.vim
"| Source  : https://github.com/fabi1cazenave/kalahari.vim
"| Licence : WTFPL
"|
"| This is a modified 'desert' theme with 256/88-color support.
"|

hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name="kalahari"

" source this file on save to apply all changes immediately {{{
if has("autocmd")
  autocmd! bufwritepost kalahari.vim colorscheme kalahari
endif " }}}

" 8bit-to-24bit color converter {{{
" 3 color groups: 0-15 (ANSI), 16-87, 88-256
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

if exists('*HL')
  delfunction HL
endif

function HL(group, fg, bg, attr)
  let l:bg = ''
  if a:bg != -1
    let l:bg = ' guibg=#' . s:rgb[a:bg] . ' ctermbg=' . a:bg
  endif

  let l:fg = ''
  if a:fg != -1
    let l:fg = ' guifg=#' . s:rgb[a:fg] . ' ctermfg=' . a:fg
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

" 256-color mode, adapted from 'desert256' {{{
if has('gui_running') || has('termguicolors') || &t_Co == 256

  " grey scale
  let s:bg_0       = 16  " #000000
  let s:bg_1       = 232
  let s:bg_2       = 233
  let s:bg_3       = 234
  let s:bg_4       = 235
  let s:bg_5       = 236
  let s:bg_6       = 237
  let s:bg_7       = 238
  let s:bg_8       = 239
  let s:bg_9       = 240
  let s:bg_10      = 241
  let s:bg_11      = 242
  let s:bg_12      = 243
  let s:fg_0       = 231 " #ffffff
  let s:fg_1       = 255
  let s:fg_2       = 254
  let s:fg_3       = 253
  let s:fg_4       = 252
  let s:fg_5       = 251
  let s:fg_6       = 250
  let s:fg_7       = 249
  let s:fg_8       = 248
  let s:fg_9       = 247
  let s:fg_10      = 246
  let s:fg_11      = 245
  let s:fg_12      = 244

  " UI palette
  let s:Normal     = s:fg_1
  let s:Normal_bg  = s:bg_3
  let s:NonText    = 152
  let s:NonText_bg = s:bg_4

  " syntax palette
  let s:Comment    = s:fg_9
  let s:Constant   = 217
  let s:Identifier = 120
  let s:Statement  = 39
  let s:PreProc    = 167
  let s:Type       = 178
  let s:Special    = 223
  let s:Underlined = 81
  let s:Ignore     = 240
  let s:Error      = 15
  let s:Error_bg   = 9
  let s:Todo       = 255
  let s:Todo_bg    = 167

  call HL('Normal',        s:fg_1, s:bg_3,  '')
  call HL('NormalNC',      -1,     -1,      '')

  call HL('NonText',       152,    s:bg_4,  'bold')
  call HL('EndOfBuffer',   -1,     -1,      '')

  " UI groups, see `:help highlight-groups` {{{
  call HL('ColorColumn',   -1,      s:bg_4,  'none')
  call HL('Conceal',       -1,      -1,      '')
  call HL('Cursor',        66,      222,     '')
 "call HL('CursorIM',      66,      222,     '')
 "call HL('CursorColumn',  -1,      s:bg_11, '')
  call HL('CursorLine',    -1,      s:bg_5,  'none')
 "call HL('Directory',     159,     -1,      '')
 "call HL('DiffAdd',       -1,      4,       '')
 "call HL('DiffChange',    -1,      5,       '')
 "call HL('DiffDelete',    12,      6,       '')
 "call HL('DiffText',      -1,      9,       'bold')
  call HL('TermCursor',    66,      222,     '')
  call HL('TermCursorNC',  66,      222,     '')
 "call HL('ErrorMsg',      15,      1,       '')
  call HL('VertSplit',     s:bg_7,  s:bg_9,  'none')
  call HL('Folded',        s:bg_12, s:bg_6,  '')
  call HL('FoldColumn',    s:bg_12, s:bg_6,  '')
  call HL('SignColumn',    118,     s:bg_4,  '')
  call HL('IncSearch',     62,      222,     'reverse')
  call HL('Substitute',    -1,      -1,      '')
  call HL('LineNr',        s:fg_12, -1,      '')
  call HL('CursorLineNr',  s:fg_12, -1,      '')
 "call HL('MatchParen',    -1,       6,      '')
  call HL('ModeMsg',       178,     -1,      'bold')
  call HL('MsgSeparator',  -1,      -1,      '')
  call HL('MoreMsg',       29,      -1,      '')
  call HL('Pmenu',         4,       s:bg_1,  '')
  call HL('PmenuSel',      s:fg_4,  s:bg_4,  'bold')
  call HL('PmenuSbar',     -1,      s:bg_3,  '')
  call HL('PmenuThumb',    -1,      s:bg_6,  '')
  call HL('Question',      48,      -1,      'bold')
  call HL('QuickFixLine',  -1,      -1,      '')
  call HL('Search',        223,     61,      '')
  call HL('SpecialKey',    111,     -1,      '')
  call HL('SpellBad',      s:fg_6,  s:bg_4,  'undercurl')
 "call HL('SpellBad',      -1,      9,       '')
 "call HL('SpellCap',      -1,      12,      '')
 "call HL('SpellLocal',    -1,      14,      '')
 "call HL('SpellRare',     -1,      13,      '')
  call HL('StatusLine',    145,     16,      'reverse,bold')
  call HL('StatusLineNC',  0,       s:bg_9,  'none')
  call HL('TabLine',       s:fg_6,  s:bg_6,  'underline')
  call HL('TabLineFill',   -1,      s:bg_6,  'none')
 "call HL('TabLineSel',    167,     s:bg_7,  '')
 "call HL('TabLineSel',    -1,      -1,      'bold')
  call HL('Title',         167,     -1,      'bold')
  call HL('Visual',        s:fg_2,  68,      '')
  call HL('VisualNOS',     -1,      -1,      'bold,underline')
  call HL('WarningMsg',    209,     -1,      '')
  call HL('Whitespace',    s:bg_9,  -1,      '')
 "call HL('WildMenu',      0,       11,      '')
  "}}}

  " standard syntax groups, see `:help group-name` {{{
  call HL('Comment',         s:Comment,     -1,            '')
  call HL('Constant',        s:Constant,    -1,            '')
  call HL('Boolean',         -1,            -1,            '')
  call HL('Character',       -1,            -1,            '')
  call HL('Float',           -1,            -1,            '')
  call HL('Number',          -1,            -1,            '')
  call HL('String',          -1,            -1,            '')
  call HL('Identifier',      s:Identifier,  -1,            '')
  call HL('Function',        -1,            -1,            '')
  call HL('Statement',       s:Statement,   -1,            'bold')
  call HL('Conditional',     -1,            -1,            '')
  call HL('Repeat',          -1,            -1,            '')
  call HL('Label',           -1,            -1,            '')
  call HL('Operator',        -1,            -1,            '')
  call HL('Keyword',         -1,            -1,            '')
  call HL('Exception',       -1,            -1,            '')
  call HL('PreProc',         s:PreProc,     -1,            '')
  call HL('Include',         -1,            -1,            '')
  call HL('Defile',          -1,            -1,            '')
  call HL('Macro',           -1,            -1,            '')
  call HL('PreCondit',       -1,            -1,            '')
  call HL('Type',            s:Type,        -1,            '')
  call HL('StorageClass',    -1,            -1,            '')
  call HL('Structure',       -1,            -1,            '')
  call HL('Typedef',         -1,            -1,            '')
  call HL('Special',         s:Special,     -1,            '')
  call HL('SpecialChar',     -1,            -1,            '')
  call HL('SpecialComment',  -1,            -1,            '')
  call HL('Tag',             -1,            -1,            '')
  call HL('Delimiter',       -1,            -1,            '')
  call HL('Debug',           -1,            -1,            '')
  call HL('Underlined',      s:Underlined,  -1,            'underline')
  call HL('Ignore',          s:Ignore,      -1,            '')
  call HL('Error',           s:Error,       s:Error_bg,    '')
  call HL('Todo',            s:Todo,        s:Todo_bg,     '')
  "}}}

  " Vim highlighting {{{
  call HL('vimCommand',      s:Statement,   -1, 'bold')
  call HL('vimCommentTitle', s:Comment,     -1, 'bold')
  call HL('vimFunction',     s:Identifier,  -1, '')
  call HL('vimFuncName',     s:Identifier,  -1, '')
  call HL('vimHighlight',    s:Statement,   -1, '')
  call HL('vimLineComment',  s:Comment,     -1, 'italic')
  call HL('vimParenSep',     s:fg_3,        -1, '')
  call HL('vimSep',          -1,            -1, '')
  call HL('vimUserFunc',     s:Identifier,  -1, '')
  call HL('vimVar',          s:Type,        -1, '')
  " }}}

  " JavaScript highlighting {{{
  call HL('javaScriptBraces',       -1,            -1, '')
  call HL('javaScriptFunction',     s:Statement,   -1, '')
  call HL('javaScriptIdentifier',   s:Identifier,  -1, '')
  call HL('javaScriptNull',         s:Constant,    -1, '')
  call HL('javaScriptNumber',       s:Constant,    -1, '')
  call HL('javaScriptRequire',      s:Statement,   -1, '')
  call HL('javaScriptReserved',     s:Statement,   -1, '')
  " https://github.com/pangloss/vim-javascript
  call HL('jsArrowFunction',        s:Statement,   -1, 'bold')
  call HL('jsBraces',               s:fg_2,        -1, '')
  call HL('jsClassBraces',          s:fg_2,        -1, '')
  call HL('jsClassKeywords',        s:Special,     -1, 'bold')
  call HL('jsDocParam',             -1,            -1, '')
  call HL('jsDocTags',              -1,            -1, '')
  call HL('jsFuncBraces',           s:fg_2,        -1, '')
  call HL('jsFuncCall',             s:Statement,   -1, '')
  call HL('jsFuncParens',           s:fg_3,        -1, '')
  call HL('jsFunction',             s:Statement,   -1, '')
  call HL('jsGlobalObjects',        s:Identifier,  -1, 'bold')
  call HL('jsModuleWords',          s:PreProc,     -1, '')
  call HL('jsModules',              s:PreProc,     -1, '')
  call HL('jsNoise',                s:fg_9,        -1, '')
  call HL('jsNull',                 s:Constant,    -1, '')
  call HL('jsOperator',             s:Statement,   -1, '')
  call HL('jsParens',               s:fg_2,        -1, '')
  call HL('jsStorageClass',         s:Type,        -1, '')
  call HL('jsTemplateBraces',       -1,            -1, '')
  call HL('jsTemplateVar',          -1,            -1, '')
  call HL('jsThis',                 s:Special,     -1, '')
  call HL('jsUndefined',            s:Special,     -1, '')
  call HL('jsObjectValue',          s:Constant,    -1, '')
  call HL('jsObjectKey',            s:Identifier,  -1, '')
  call HL('jsReturn',               s:Statement,   -1, '')
  " https://github.com/othree/yajs.vim
  call HL('javascriptArrowFunc',    s:Statement,   -1, 'bold')
  call HL('javascriptClassExtends', s:Statement,   -1, '')
  call HL('javascriptClassKeyword', s:Statement,   -1, '')
  call HL('javascriptDocNotation',  -1,            -1, '')
  call HL('javascriptDocParamName', -1,            -1, '')
  call HL('javascriptDocTags',      -1,            -1, '')
  call HL('javascriptEndColons',    s:Statement,   -1, '')
  call HL('javascriptExport',       s:PreProc,     -1, '')
  call HL('javascriptFuncArg',      -1,            -1, '')
  call HL('javascriptFuncKeyword',  s:Statement,   -1, '')
  call HL('javascriptIdentifier',   s:Identifier,  -1, '')
  call HL('javascriptImport',       s:PreProc,     -1, '')
  call HL('javascriptObjectLabel',  s:Identifier,  -1, '')
  call HL('javascriptOpSymbol',     -1,            -1, '')
  call HL('javascriptOpSymbols',    -1,            -1, '')
  call HL('javascriptPropertyName', s:Identifier,  -1, '')
  call HL('javascriptTemplateSB',   -1,            -1, '')
  call HL('javascriptVariable',     s:Statement,   -1, '')
  " }}}

"}}}

" 88-color mode, adapted from 'desert256' {{{
elseif &t_Co == 88
  hi Normal       ctermfg=87   ctermbg=16
  hi NonText      ctermfg=59   ctermbg=80   cterm=bold

  " UI groups {{{
  hi Cursor       ctermfg=12   ctermbg=77
  hi CursorLine                ctermbg=81   cterm=none
  hi ColorColumn               ctermbg=81   cterm=none
  hi FoldColumn   ctermfg=57   ctermbg=80
 "hi Folded       ctermfg=72   ctermbg=80
  hi Folded       ctermfg=53   ctermbg=80
  hi IncSearch    ctermfg=37   ctermbg=77   cterm=reverse
 "hi LineNr       ctermfg=11
  hi LineNr       ctermfg=83
  hi ModeMsg      ctermfg=52                cterm=bold
  hi MoreMsg      ctermfg=21
  hi Question     ctermfg=29
  hi Search       ctermfg=74   ctermbg=52
  hi SpecialKey   ctermfg=40
  hi StatusLine   ctermfg=58   ctermbg=16   cterm=reverse,bold
  hi StatusLineNC ctermfg=0    ctermbg=82   cterm=none
  hi TabLine      ctermfg=15   ctermbg=82   cterm=underline
  hi TabLineFill               ctermbg=84   cterm=none
  hi Title        ctermfg=53
  hi VertSplit    ctermfg=80   ctermbg=82   cterm=none
  hi Visual       ctermfg=36   ctermbg=77   cterm=reverse
  hi WarningMsg   ctermfg=69
  "}}}

  " syntax groups {{{
  hi Comment      ctermfg=43
  hi Constant     ctermfg=69
  hi Identifier   ctermfg=45
  hi Ignore       ctermfg=81
 "hi Preproc      ctermfg=53
  hi Preproc      ctermfg=65
 "hi Preproc      ctermfg=64
 "hi Preproc      ctermfg=1
  hi Special      ctermfg=74
 "hi Statement    ctermfg=77                cterm=bold
  hi Statement    ctermfg=52                cterm=bold
 "hi StorageClass ctermfg=117
  hi Todo         ctermfg=68   ctermbg=76
  hi Type         ctermfg=57                cterm=bold
  "}}}

"}}}

" default color terminal definitions {{{
else
  hi Comment      ctermfg=darkcyan
  hi Constant     ctermfg=brown
  hi DiffAdd                         ctermbg=4
  hi DiffChange                      ctermbg=5
  hi DiffDelete   ctermfg=4          ctermbg=6      cterm=bold
  hi DiffText                        ctermbg=1      cterm=bold
  hi Directory    ctermfg=darkcyan
  hi Error        ctermfg=7          ctermbg=1      cterm=bold
  hi Errormsg     ctermfg=7          ctermbg=1      cterm=bold
  hi FoldColumn   ctermfg=darkgrey   ctermbg=none
  hi Folded       ctermfg=darkgrey   ctermbg=none
  hi Identifier   ctermfg=6
  hi Ignore       ctermfg=7                         cterm=bold
  hi Ignore       ctermfg=darkgrey
  hi IncSearch    ctermfg=yellow     ctermbg=green  cterm=none
 "hi LineNr       ctermfg=3
  hi LineNr       ctermfg=grey
  hi ModeMsg      ctermfg=brown                     cterm=none
  hi MoreMsg      ctermfg=darkgreen
  hi NonText      ctermfg=darkblue                  cterm=bold
  hi Preproc      ctermfg=5
  hi Question     ctermfg=green
  hi Search       ctermfg=grey       ctermbg=blue   cterm=none
  hi Special      ctermfg=5
  hi SpecialKey   ctermfg=darkgreen
  hi Statement    ctermfg=3
  hi StatusLine                                     cterm=bold,reverse
  hi StatusLineNC                                   cterm=reverse
 "hi StorageClass ctermfg=darkcyan
  hi Title        ctermfg=5
  hi Type         ctermfg=2
  hi Underlined   ctermfg=5                         cterm=underline
  hi VertSplit                                      cterm=reverse
  hi Visual                                         cterm=reverse
  hi VisualNOS                                      cterm=bold,underline
  hi WarningMsg   ctermfg=1
  hi WildMenu     ctermfg=0          ctermbg=3
endif
"}}}

" vim: set fdm=marker fmr={{{,}}} fdl=0:
