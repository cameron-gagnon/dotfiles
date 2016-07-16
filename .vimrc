set nocompatible              " be iMproved, required must be first in .vimrc file
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => VUNDLE PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'

" a bunch of color schemes for vim
Plugin 'flazz/vim-colorschemes'

" autogenerate ctags files plugin
Plugin 'szw/vim-tags'

" rsync stuff
Plugin 'jacob-ogre/vim-syncr'

" NERDTree
"Plugin 'scrooloose/nerdTree'

" git-status-flag plugin for NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'

" End configuration, makes the plugins available
filetype plugin indent on


"Reload vimrc after editing
augroup reload_vimrc " {{{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => vim-syncr shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePost * :Suplfil     " automatic syncr upload on write

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => NERDTree shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd vimenter * NERDTree         " automatic nerdtree on entering vim
"" shortcut to toggle nerdtree
"map <C-n> :NERDTreeToggle<CR>
"" close vim if the only window open is NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"" stop NERDTree from starting on vim's start
"let g:NERDTreeHijackNetrw=0
"" show hidden files on startup
"let g:NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => You Complete Me Package ^^^
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0
" set when the preview window will close
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion  = 1

" don't ever show preview window
"set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => Text and spacing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Everything adjusts to 4 spaces
set tabstop=4                   "Tab has length 4 spaces
"set softtabstop=4               "Tabs equate to 4 spaces
set expandtab                   "Tabs become softtabstop spaces

" Makefiles require tabs not spaces
"augroup makefile
"    autocmd!
"    autocmd FileType make setlocal noexpandtab
"augroup END

set list                        " Show whitespace characters
set listchars=tab:>-,trail:%    " helps notice bad tabbing & eliminates
                                " trailing whitespace characters

set shiftwidth=4                ">> shifts 4 spaces
set shiftround                  "Round indents to multiple of shiftwidth

set smarttab                    "<BS> deletes 1 tab's worth of spaces
set autoindent                  "Copy current indent when new line starts

set colorcolumn=80              "Highlight column 81 for line breaks

"set paste                       "Allow pasting from the clipboard
set pastetoggle=<F9>            "Toggle pasting from clipboard

let python_highlight_all = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:solarized_termcolors=16  "Used the reduced set of 256 colors in terminal
syntax enable                   "Enable syntax highlighting
set background=dark
"colorscheme solarized          "Set colorscheme to solarized
"set colo koehler               "Sets colorscheme to koehler

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      " Show line numbers
set showcmd                     " Show command in the bottom bar
set spell spelllang=en_us       " Specify English_US locale
hi clear SpellBad
hi clear SpellCap
hi SpellBad ctermfg=LightRed
hi SpellCap ctermfg=LightGreen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Removes trailing spaces
function TrimExtraWhiteSpace()
    %s/\s\+$
:endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off serach highlight using three hits of the space bar>
nnoremap <Space><Space><Space> :nohlsearch<CR>

" For a line wrapped to two lines, j and k won't skip over the wrapped part
nnoremap j gj
nnoremap k gk
" jj becomes <ESC>:wq if typed fast enough - exits the file
"inoremap jj <Esc> :wq <CR>
" Hitting Space + K causes a CTRL + D to be entered
nnoremap <Space>j <C-d>+
" Hitting Space + K causes a CTRL + U to be entered
nnoremap <Space>k <C-u><CR>

let mapleader=","             "Leader becomes a comma

" Suppsed to display undo tree; GundoToggle is unrecongized?
" nnoremap <leader>u :GundoToggle<CR>

map <F2> :call TrimExtraWhiteSpace()<CR>
map! <F2> :call TrimExtraWhiteSpace()<CR>
" opens Explorer mode with Ctrl-n
map <C-n> :E<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => Typing Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler                       "Always show current position
"set cursorline                  "Highlight current line, horizontal line

set visualbell                  "Visual cues on errors
set nowrap                      "Wrap long lines
set linebreak                   "Wrap lines at words instead of letters

set showmatch                   "Show matching parentheses
set matchtime=2                 "Length matched paren flashes (1/10 sec)
set matchpairs=(:),{:},[:],<:>  "Chars in a balanced pair

set wildmenu                    "Visual autocomplete for command menu

set incsearch                   "Search as characters are entered
"set hlsearch                    "Highlight matches
set mouse=a                     "enable scrolling with the mouse

set backspace=2                 " make backspace work like most other apps

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   => Filetype Based Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on                     "Enable filetype detection
filetype indent on              "Enable filetype indentation
filetype plugin on              "Enable filetype plugins
filetype plugin indent on       "Enalbe filetype plugin indentation



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    GOOGLE FORMATTING FOR PYTHON                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function! GetGooglePythonIndent(lnum)

    "Indent inside parens.
    " Align with the open paren unless it is at the end of the line.
    " E.g.
    "   open_paren_not_at_EOL(100,
    "                         (200,
    "                          300),
    "                         400)
    "   open_paren_at_EOL(
    "       100, 200, 300, 400)
    call cursor(a:lnum, 1)
    let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
          \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
          \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
          \ . " =~ '\\(Comment\\|String\\)$'")
    if par_line > 0
        call cursor(par_line, 1)
        if par_col != col("$") - 1
            return par_col
        endif
    endif
    "Delegate the rest to the original function.
    return GetPythonIndent(a:lnum)
endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                 CSCOPE USAGE                      """"""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                 POWERLINE                         """"""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                 CTRL-P                            """"""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
