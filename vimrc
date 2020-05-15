" Mostly based on https://dougblack.io/words/a-good-vimrc.html and
" https://github.com/thoughtbot/dotfiles/blob/master/vimrc

scriptencoding utf-8

let mapleader = ","

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set encoding=utf-8
set list listchars=tab:»·,trail:·,nbsp:· " Display whitespace   
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    "Indent by 4 spaces when using >>, <<, == etc.
set expandtab       " tabs are spaces
set number          " show line numbers
set numberwidth=3
set showcmd         " show command in bottom bar
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set ruler         " show the cursor position all the time
set incsearch     " do incremental searching
set hlsearch            " highlight matches
set wildignore+=*/.git/*,*/tmp/*,*.swp " Files to ignore for autocomplete
set wildmenu            " visual autocomplete for command menu
set autowrite     " Automatically :write before running commands
set backspace=2   " Backspace deletes like most programs in insert mode
set history=50
set laststatus=2 " Always show the statusline.
set noshowmode " Don't show -- INSERT -- since the mode is shown by lightline.

" Store backups in /tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Open new split panes to right and bottom, which feels more natural"
set splitbelow
set splitright

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Enable filetype plugins
filetype plugin on
filetype indent on

" Disable sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Hide parts of GUI
set guioptions-=m  " menu bar
set guioptions-=T  " toolbar
set guioptions-=r  " right scrollbar
set guioptions-=L  " left scrollbar

" Plugins (using https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'wlangstroth/vim-racket'
Plug 'djoshea/vim-autoread' " Reload files automatically from the filesystem.
Plug 'NLKNguyen/papercolor-theme'
Plug 'cohama/lexima.vim' " Auto-close parens.
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'ElmCast/elm-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'jez/vim-better-sml'
Plug 'bohlender/vim-smt2'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set t_Co=256
set background=light
colorscheme PaperColor

let g:gundo_prefer_python3 = 1 " Use python3 for gundo

map <C-\> :NERDTreeToggle<CR> " Ctrl-\ toggles file tree

" Use ripgrep if available
if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_switch_buffer = 0 " Open files in new buffer

let g:elm_format_autosave = 1


" Coc Configuration
" =================
" See https://github.com/neoclide/coc.nvim#example-vim-configuration

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" (<C-y> confirms completion)

" Navigate errors.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
