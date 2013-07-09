" ======================================
" .vimrc Daniel Ryan <hawkerz@gmail.com>
" ======================================



" Setup {{{
" ======

    if !exists('s:loaded_my_vimrc')

        set nocompatible        " enables VIM features over old style VI ones

        set nobackup            " Disable backup
        set nowritebackup       " Disable backup
        set noswapfile          " Disable swap file writing

        let g:SESSION_DIR = $HOME.'/.cache/vim/sessions'

        if finddir(g:SESSION_DIR) == ''
            silent call mkdir(g:SESSION_DIR, "p")
        endif

	let iCanHazVundle=1
        let vundle_readme=expand("~/.vim/bundle/vundle/README.md")
        if !filereadable(vundle_readme) 
        "if !isdirectory("~/.vim/bundle/vundle")
            echo "Installing Vundle.."
            echo ""
            silent !mkdir -p ~/.vim/bundle
            silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
            let iCanHazVundle=0
        endif

        " Load Vundle
        filetype off
	" Vundle requires posix compliance, ergo bash
	set shell=bash
	let $GIT_SSL_NO_VERIFY = 'true'
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	" Vundle manages itself, required!!!
	Bundle 'gmarik/vundle'
	" Bundle 'tpope-vim-fugitive'

	" 
	Bundle 'git://git.wincent.com/command-t.git'
	Bundle 'sjl/gundo.vim'
	" Bundle 'L9'

	" Syntax highlighting for nginx config
	Bundle 'mutewinter/nginx.vim'

	" Fuzzy finder (files, mru cache, etc)
	Bundle 'kien/ctrlp.vim'

	" Javascript syntax highlighting
	Bundle 'pangloss/vim-javascript'

	" Jquery plugin
	Bundle 'itspriddle/vim-jquery'

	" Filesystem explorer
	Bundle 'scrooloose/nerdtree'

	" Snippet tools (all are required)
	Bundle 'MarcWeber/vim-addon-mw-utils'
	Bundle 'tomtom/tlib_vim'
	Bundle 'garbas/vim-snipmate'
	Bundle 'honza/vim-snippets'
	Bundle 'scrooloose/syntastic'

	" Git plugins
	Bundle 'tpope/vim-git'
	Bundle 'tpope/vim-fugitive'

	Bundle 'ervandew/supertab'

	" Various generic formatters for alignment and bracket matching
	Bundle 'Townk/vim-autoclose'
	" Bundle 'tsaleh/vim-align'
	Bundle 'vim-scripts/Align'
	Bundle 'tpope/vim-surround'
	Bundle 'scrooloose/nerdcommenter'
	Bundle 'michaeljsmith/vim-indent-object'
	Bundle 'fholgado/minibufexpl.vim'
        Bundle 'myusuf3/numbers.vim'
	let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

	" Tmux extensions
	Bundle 'benmills/vimux'

	" Language specific helpers
	Bundle 'plasticboy/vim-markdown'
	Bundle 'klen/python-mode'
	Bundle 'swaroopch/vim-markdown-preview'
	Bundle 'davidhalter/jedi-vim'

	" Color schemes
	Bundle 'nanotech/jellybeans.vim'
	" Bundle 'acustodioo/vim-tmux'
	Bundle 'Lokaltog/powerline', {'rtp':'/powerline/bindings/vim'}
	Bundle 'chriskempson/vim-tomorrow-theme'
	Bundle 'altercation/vim-colors-solarized'
	Bundle 'jelera/vim-gummybears-colorscheme'
	Bundle 'hickop/vim-hickop-colors'
	Bundle 'sjl/badwolf'
	Bundle 'tomasr/molokai'
	Bundle 'zaiste/Atom'
	Bundle 'w0ng/vim-hybrid'



    endif

" }}}

filetype plugin indent on
syntax on

set nocompatible

" Source viminit files {{{
    runtime! config/**/*.vim

" Options {{{
" =======

    " Buffer options
    set hidden                  " hide abandoned buffers
    set autoread                " auto relaod changed files
    set autowrite               " autosave before make and next

    " Display Options
    set title                   " show file name in window title
    set novisualbell              " Mute error bell
    set noerrorbells
    set listchars=tab:>\                            " > to highlight <tab>
    " set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~ 
    set list
    set linebreak               " break lines by words
    set showcmd
    " set whichwrap=b,s,<,>,[,],l,h
    set completeopt=menu,preview
    " set completeopt=menuone,longest,preview
    set omnifunc=pythoncomplete#Complete
    set infercase
    " set cmdheight=2
    set showmode
    set number                  " Enable line numbering
    set ruler                   " Always show cursor position
    set colorcolumn=81          " Show vertical line at column 81 (dont pass)
    set cursorline              " Hightlight current line
    set nowrap
    "set lazyredraw
    " set tw=79                 " Document width

    " Tab options
    set autoindent              " copy indent from previous line
    set smartindent             " enable nice indent
    set expandtab               " tab with spaces
    set smarttab                " indent using shiftwidth
    set shiftwidth=4            " spaces per indent
    set softtabstop=4           " tab is like 4 spaces
    set softtabstop=4
    set shiftround              " drop unused spaces

    " Backup file options
    set history=700             " history length
    set viminfo+=h              " save history file
    set ssop-=blank             " Don't save blank windows
    set ssop-=options           " don't save options
    set undolevels=700

    " Search options
    set hlsearch                " hilight search results
    set ignorecase              " case insensitive searching
    set smartcase               " override ignorecase when searching for caps
    set incsearch               " show pattern matches while typing

    " Matching characters
    set showmatch               " show matching brackets
    set matchpairs+=<:>         " < and > are now matching brackets

    " Localization
    set langmenu=none           " always use english
    set iminsert=0              " English by default
    set imsearch=-1             " Search keymap from insert mode
    set spelllang=en            " Spellcheck languages
    set encoding=utf-8          " Default encoding
    set fileencodings=utf-8
    set termencoding=utf-8

    set scrolloff=2             " Start scrolling 8 away from margins
    set sidescrolloff=2
    set sidescroll=1

    " Wildmenu
    set wildmenu                " Use wildmenu
    " set wildcharm=<TAB>
    set wildignore=.pyc,.back,.o,.obj,.pdf,.jpg,so " Ignore .pyc files
    " set wildignore+=*_build/*
    " set wildignore+=*/coverage/*
    set wildmode=list:longest,full " Tab shows completion options like in shell
    set laststatus=2

    " Undo
    if has('persistent_undo')
        set undofile            " enable persistent undo
        set undodir=/tmp/       " store undo files in a tmp dir
    endif

    " Folding
    if has('folding')
        set foldmethod=marker   " Fold on marker
        set foldlevel=2         " High default = folds are shown to start
        set foldenable
        set foldcolumn=0
        " set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
    endif

    set clipboard=unnamed,unnamedplus,autoselect

    " Edit
    set backspace=indent,eol,start  " backspace deletes indent, newline, text
    " set bs=2                        " make backspace act normal
    "set virtualedit=onemore             " virtualedit for all modes, block, insert, or onemore
    set mouse=a                     " activate mouse for gui interaction

    set confirm
    " set numberwidth=2               " Line numbers no more than 2 wide
    set formatoptions=crqwnl1                      " Don't auto-wrap while typing

    " Open help in vsplit rather than regular split
    " command! -nargs=? -complete=help Help :vertical help <args>
    " cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

" }}}



" Plugin setup {{{
" ============

    " CTRLP
    let g:ctrlp_max_height = 30

" }}}


if filereadable($HOME . "/.vim_local.vim")
    source $HOME/.vim_local.vim
endif

" Project Settings {{{
" ================

    " Enables reading .vimrc, .exrc and .gvimrc in current directory
    set exrc

    " Must go last (see :help 'secure'.)
    set secure

" }}}