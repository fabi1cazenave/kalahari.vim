This is a modified 'desert' theme with 256/88-color support.  
Two main principles have been taken from the 'wombat' theme:

* reduced the contrast (gray shades) on some secondary groups:
  Comment, LineNr, VertSplit, StatusLine, TabLine  
  => better code readability: the important parts stand out;
* no more ugly yellow for Statement and Folded:
  Statement becomes blue, Folded becomes golden  
  => should look nicer with most filetypes (especially HTML).

The 256/88-color conversion has been made with the 'desert256' theme.
I didn't keep the color conversion functions because they require too much CPU
(a hardcoded conversion is faster) and some fine tuning is necessary, especially
in 88-color mode.

These color modes have been tested in the following terminal emulators:

* full colors: gVim
*  256 colors: xterm (Gnome-terminal, Xfce4-terminal, ...)
*   88 colors: rxvt  (urxvt, ...)

See also:

* ["desert" theme](http://hans.fugal.net/vim/colors/desert.vim) by Hans Fugal
* ["desert256" theme](http://www.vim.org/scripts/script.php?script_id=1243) by Henry So, Jr.
* ["wombat" theme](http://www.vim.org/scripts/script.php?script_id=1778) by Lars H. Nielsen
* ["wombat256" theme](http://www.vim.org/scripts/script.php?script_id=2465) by David Liang
* ["The 256 color mode of xterm"](http://www.frexx.de/xterm-256-notes/) by Wolfgang Frisch

