" Leader
let mapleader = " "

" Source local vim settings if they exist, but fail quietly if not.
silent! so .vimlocal

" Strip trailing whitespace
noremap <Leader>W :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>, :tabe $MYVIMRC<CR>
nnoremap <Leader>m :Make<CR>
nnoremap <Leader>h :noh<CR>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" vim-test mappings
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tg :TestVisit<CR>

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
nmap <Leader>c <Plug>(ale_fix)

" Make it easy to correct spelling
nnoremap <leader>f 1z=

" Normal mode dot command in visual mode
" vnoremap . :norm.<CR>

" Make the word just typed behind the cursor all caps using C-F in insert mode
map! <C-F> <Esc>gUiw`]a

command! Wd w|bd " Command to save and close buffer

set nocompatible              " be iMproved
filetype plugin indent on

packadd! matchit " Enable matchit package

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set up solarized theme
syntax enable
set background=dark
colorscheme solarized

set autoread " Auto-reload changed files
set clipboard=unnamed
set cursorline cursorcolumn
set display=lastline " Show as much as possible if really long lines are cut off
set expandtab
" set foldmethod=syntax " Fold based on syntax rules
set history=50 " keep 50 lines of command line history
set hidden " When leaving a buffer with unsaved changes, keep it loaded but hidden
set ignorecase
set incsearch " do incremental searching
set laststatus=2 " Always show the status bar
set lazyredraw
set ruler " show the cursor position all the time
set scrolloff=1 " Keep one like visible at top and bottom for vertical scroll
set sessionoptions-=options " Don't remember options when saving session
set showcmd " display incomplete commands
set sidescrolloff=5 " Keep 5 columns visible at edge for horizontal scroll
set smartcase " case-smart searching
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set thesaurus+=/Users/ross/.vim/thesaurus/thesaurus.txt
" set switchbuf=ewtab
set tabstop=2 shiftwidth=2
set wildmenu " show menu for autocompleting vim commands
" Remember constants (!)
" Remember buffers that were open (used for restoring them if desired) (%)
set viminfo^=!,%

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Display extra whitespace, excluding ,eol:¬ for now
set list listchars=tab:»·,trail:·,nbsp:·

set number " Show line numbers
" set number relativenumber " hybrid line numbers
" Use hybrid line numbers where it makes sense, otherwise use absolute
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0


  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore,react,flux,d3'

" vim-jsx
let g:jsx_ext_required = 0

" vim-test running strategy
let test#strategy = "dispatch"

" Fix all errors in an 'unsafe' manner
let g:ale_ruby_rubocop_auto_correct_all=1
let g:ale_ruby_rubocop_executable='bundle'
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'ruby': ['rubocop'],
\   'javascript': ['eslint', 'prettier'],
\}

" Autocomplete load rails environment
let g:rubycomplete_rails = 1

" configure fugitive
" set statusline=%{fugitive#statusline()}
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  " set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let ruby_space_errors = 1



