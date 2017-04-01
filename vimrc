colorscheme elflord
set laststatus=2
set mouse=a
"How much command history vim has to remember
set history=1000

" Enabling filetype plugins
filetype plugin on
filetype indent on

" Autoread when a file changes from the outside
set autoread

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Always show the current position
set ruler

" Be smart about case when searching
set smartcase

" Highlight search results
set hlsearch

" Makes search act like modern browsers
set incsearch

" Don't redraw buffers when executing macros (good performance config)
" set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=5

" Modern backspace behaviour
set backspace=indent,eol,start

" Wildmenu
set wildmenu
" Set the complete mode for status line
set wildmode=list:longest

" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting

syntax enable

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use space instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Change the size of the tabs on python, cpp
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding enabled by default
set foldenable

" Set space to open/close folds
" nnoremap <space> za

" set foldmethod=syntax

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_winsize=-28
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_browse_split=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close a buffer without losing the previously opened Vsplit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-c> :bp\|bd #<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nlknguyen/c-syntax.vim'
Plug 'davidhalter/jedi-vim'
" On-demand loading
call plug#end()

let g:airline_powerline_fonts = 1
set t_Co=256
set encoding=utf-8

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Code Completion
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0


function! s:onCompleteDone()
  let abbr = v:completed_item.abbr
  let startIdx = stridx(abbr,"(")
  let endIdx = strridx(abbr,")")
  if endIdx - startIdx > 1
    let argsStr = strpart(abbr, startIdx+1, endIdx - startIdx -1)
    "let argsList = split(argsStr, ",")

    let argsList = []
    let arg = ''
    let countParen = 0
    for i in range(strlen(argsStr))
      if argsStr[i] == ',' && countParen == 0
        call add(argsList, arg)
        let arg = ''
      elseif argsStr[i] == '('
        let countParen += 1
        let arg = arg . argsStr[i]
      elseif argsStr[i] == ')'
        let countParen -= 1
        let arg = arg . argsStr[i]
      else
        let arg = arg . argsStr[i]
      endif
    endfor
    if arg != '' && countParen == 0
      call add(argsList, arg)
    endif
  else
    let argsList = []
  endif

  let snippet = '('
  let c = 1
  for i in argsList
    if c > 1
      let snippet = snippet . ", "
    endif
    " strip space
    let arg = substitute(i, '^\s*\(.\{-}\)\s*$', '\1', '')
    let snippet = snippet . '${' . c . ":" . arg . '}'
    let c += 1
  endfor
  let snippet = snippet . ')' . "$0"
  return UltiSnips#Anon(snippet)
endfunction
autocmd VimEnter * imap <expr> (
      \ pumvisible() && exists('v:completed_item') && !empty(v:completed_item) &&
      \ v:completed_item.word != '' && v:completed_item.kind == 'f' ?
      \ "\<C-R>=\<SID>onCompleteDone()\<CR>" : "<Plug>delimitMate("
