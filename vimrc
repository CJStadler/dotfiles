" Mostly based on https://dougblack.io/words/a-good-vimrc.html and
" https://github.com/thoughtbot/dotfiles/blob/master/vimrc

colorscheme github " https://github.com/endel/vim-github-colorscheme/blob/master/colors/github.vim

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set list listchars=tab:»·,trail:·,nbsp:· " Display whitespace   
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set number          " show line numbers
set numberwidth=5
set showcmd         " show command in bottom bar
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set ruler         " show the cursor position all the time
set incsearch     " do incremental searching
set hlsearch            " highlight matches
set foldenable          " enable folding
set foldmethod=indent   " fold based on indent level
set wildignore+=*/.git/*,*/tmp/*,*.swp " Files to ignore for autocomplete
set autowrite     " Automatically :write before running commands
set backspace=2   " Backspace deletes like most programs in insert mode
set history=50

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

" Plugins (using https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
call plug#end()

let g:gundo_prefer_python3 = 1 " Use python3 for gundo

" Use ripgrep if available
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_switch_buffer = 0 " Open files in new buffer

