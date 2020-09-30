" ----------------------------------------------------------
"  Plugins
" ----------------------------------------------------------

" Bootstrap Vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | bd
endif

" Vim-plug
call plug#begin('~/.config/nvim/plugged')

" Vim-plug documentation
Plug 'junegunn/'        . 'vim-plug'

" Autocomplete
"Plug 'neovim/'          . 'nvim-lsp'

" Theme
Plug 'morhetz/'         . 'gruvbox'
Plug 'vim-airline/'     . 'vim-airline'

" Extensions
Plug 'michaeljsmith/'   . 'vim-indent-object'
Plug 'machakann/'       . 'vim-sandwich'
Plug 'wellle/'          . 'targets.vim'
Plug 'jiangmiao/'       . 'auto-pairs'

call plug#end()

" ----------------------------------------------------------
"  Plugin configuration
" ----------------------------------------------------------

" Theme
if !empty(glob("~/.config/nvim/plugged/gruvbox/colors/gruvbox.vim"))
  colorscheme gruvbox
  set background=dark
endif

" Sandwich
runtime macros/sandwich/keymap/surround.vim

nmap ss yss
nmap s ys
nmap S yS

" surround text objects
xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)

xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

" ----------------------------------------------------------
"  General settings
" ----------------------------------------------------------

" Line highlight
set cursorline

" Line numbering
set number relativenumber

" Search settings
set incsearch
set ignorecase
set smartcase

" Indentation settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Undo/redo settings
set undofile

" Backup settings
set nobackup
set nowritebackup

" Terminal settings
tnoremap <Esc> <C-\><C-n>

" ----------------------------------------------------------
"  Keyboard shortcuts
" ----------------------------------------------------------

" Leader key
let mapleader=" "

" Clear screen
nnoremap <C-l> :nohl<CR><C-L>

" Paragraphs
nnoremap <C-j> }
nnoremap <C-k> {

" Macros
nnoremap QQ @@
nnoremap Q @

" Undo
nnoremap U <C-r>

" Yank
nnoremap Y y$

" Marks
nnoremap § `

" Toggle Line numbering
nnoremap <silent><expr> <leader>#
  \  ":set "
  \  .(&relativenumber ? "norelativenumber number" : "relativenumber number")
  \  ."<CR>"

" ----------------------------------------------------------
"  Commands
" ----------------------------------------------------------

" Disable automatic comments
autocmd FileType * setlocal formatoptions-=cro
autocmd FileType * set formatoptions-=cro

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Reload init.vim after saving
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | PlugInstall --sync | PlugClean | bd

" Install missing plugins on start
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \  | PlugInstall --sync | PlugClean | bd
  \  endif
