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

        " Load Pathogen
        filetype off
        call pathogen#infect()
        call pathogen#helptags()

        filetype plugin indent on
        syntax on
    endif

" }}}

" Options {{{
" =======

    " Buffer options
    set hidden                  " hide abandoned buffers
    set autoread                " auto relaod changed files
    set autowrite               " autosave before make and next

    " Display Options
    set title                   " show file name in window title
    set visualbell              " Mute error bell
    set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~ 
    set linebreak               " break lines by words
    set showcmd
    set whichwrap=b,s,<,>,[,],l,h
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
    " set lazyredraw
    " set tw=79                 " Document width

    " Tab options
    set autoindent              " copy indent from previous line
    set smartindent             " enable nice indent
    set expandtab               " tab with spaces
    set smarttab                " indent using shiftwidth
    set shiftwidth=4            " spaces per indent
    set softtabstop=4           " tab is like 4 spaces
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

    set scrolloff=8             " Start scrolling 8 away from margins
    set sidescrolloff=15
    set sidescroll=1

    " Wildmenu
    set wildmenu                " Use wildmenu
    set wildcharm=<TAB>
    set wildignore=*.pyc        " Ignore .pyc files
    " set wildignore+=*_build/*
    " set wildignore+=*/coverage/*
    set wildmode=list:longest " Tab shows completion options like in shell

    " Undo
    if has('persistent_undo')
        set undofile            " enable persistent undo
        set undodir=/tmp/       " store undo files in a tmp dir
    endif

    " Folding
    if has('folding')
        set foldmethod=marker   " Fold on marker
        set foldlevel=999       " High default = folds are shown to start
        set foldenable
        " set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
    endif

    " X clipboard support
    if has('unnamedplus')
        set clipboard+=unnamed  " Enable x-clipboard
    endif

    " Terminal
    if &term =~ "xterm" || &term =~ "screen"
        set t_Co=256            " set 256 colors
        let g:solarized_termcolors=256
        let g:solarized_contrast="high"
        let g:solarized_termtrans=1
        let g:molokai_original=0
        let g:jellybeans_use_lowcolor_black=1
    else
        let g:Powerline_symbols="fancy"
    endif

    " Color theme
    set background=dark
    " colorscheme molokai
    " colorscheme Tomorrow-Night
    colorscheme jellybeans
    " colorscheme hickop
    " colorscheme oh-la-la
    " colorscheme tropikos
    " colorscheme gummybears

    " Edit
    set backspace=indent,eol,start  " backspace deletes indent, newline, text
    " set bs=2                        " make backspace act normal
    set virtualedit=all             " virtualedit for all modes
    set mouse=a                     " activate mouse for gui interaction

    set confirm
    " set numberwidth=2               " Line numbers no more than 2 wide
    set fo-=t                       " Don't auto-wrap while typing

    " Open help in vsplit rather than regular split
    " command! -nargs=? -complete=help Help :vertical help <args>
    " cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

" }}}

" Functions {{{
" =========

    " Key bind helper
    fun! rc#Map_ex_cmd(key, cmd) "{{{
        execute "nmap ".a:key." " . ":".a:cmd."<CR>"
        execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
        execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
        execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfun "}}}

    " Options switching helper
    fun! rc#Toggle_option(key, opt) "{{{
        call rc#Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfun "}}}

    " Sessions
    fun! rc#SessionRead(name) "{{{
        let s:name = g:SESSION_DIR.'/'.a:name.'.session'
        if getfsize(s:name) >= 0
            echo "Reading " s:name
            exe 'source '.s:name
            exe 'silent! source '.getcwd().'/.vim/.vimrc'
        else
            echo 'Session not found: '.a:name
        endif
    endfun "}}}

    fun! rc#SessionInput(type) "{{{
        let s:name = input(a:type.' session name? ')
        if a:type == 'Save'
            call rc#SessionSave(s:name)
        else
            call rc#SessionRead(s:name)
        endif
    endfun "}}}

    fun! rc#SessionSave(name) "{{{
        let s:name = g:SESSION_DIR.'/'.a:name.'.session'
        exe "mks! " s:name
        echo "Session " a:name "saved"
    endfun "}}}

    " Recursive vimgrep
    fun! rc#RGrep() "{{{ 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif

        let cwd = getcwd()
        let startdir = input("Start searching from directory: ", cwd, "dir")
        if startdir == ""
            return
        endif

        let filepattern = input("Search in files matching pattern: ", "*.*") 
        if filepattern == ""
            return
        endif

        execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern | botright copen
    endfun "}}} 

    " Restore cursor position
    fun! rc#restore_cursor() "{{{
        if line("'\"") <= line("$")
            normal! g`"
            " Or is it
            " normal! g'"
            return 1
        endif
    endfun "}}}

    " Templates
    fun! rc#load_template() "{{{
        let tpl_dir = $HOME . "/.vim/templates/"

        if exists("g:tpl_prefix")
            let tpl_dir = l:tpl_dir . g:tpl_prefix . "/"
        endif

        let template = ''

        let path = expand('%:p~:gs?\\?/?')
        let path = strpart(l:path, len(fnamemodify(l:path, ':h:h:h')), len(l:path))
        let parts = split(l:path, '/')

        while len(l:parts) && !filereadable(l:template)
            let template = l:tpl_dir . join(l:parts, '/')
            let parts = l:parts[1:]
        endwhile

        if !filereadable(l:template)
            let template = l:tpl_dir . &ft
        endif

        if filereadable(l:template)
            exe "0r " . l:template
        endif
    endfun "}}}

" }}}

" Autocommands {{{
" =============

    if has("autocmd")

        augroup vimrc
        au!
            
            " Auto reload vim settings
            au! BufWritePost *.vim source ~/.vimrc

            " Highlight insert mode
            au InsertEnter * set cursorline
            au InsertLeave * set nocursorline

            " Auto-load NerdTree if loading vim with no files
            au vimenter * if !argc() | NERDTree | endif

            " New file templates
            au BufNewFile * silent! call rc#load_template()

            " Restore cursor position
            au BufWinEnter * call rc#restore_cursor()

            " Beautify JS + HTML + CSS
            au FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
            au FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
            au FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

            " Autosave last session
            if has("mksession")
                au VimLeavePre * :call rc#SessionSave('last')
            endif

            " Save current file when losing focus
            " au FocusLost * if &modifiable && &modified | write | endif

            " Filetypes {{{
            " ---------
                au BufNewFile,BufRead *.json setf javascript
            "}}}


            " Auto close preview window
            autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
            autocmd InsertLeave * if pumvisible() == 0|pclose|endif

        augroup END

        " Retab python files on write
        au BufWrite *.py %retab

    endif

"}}}


" Plugin setup {{{
" ============

    let mapleader = ","

    " Tagbar
    let g:tagbar_width = 30
    let g:tagbar_foldlevel = 1
    let g:tagbar_type_rst = {
        \ 'ctagstype': 'rst',
        \ 'kinds': [
            \ 'r:references',
            \ 'h:headers'
        \ ],
        \ 'sort': 0,
        \ 'sro': '..',
        \ 'kind2scope': { 'h': 'header' },
        \ 'scope2kind': { 'header': 'h' }
    \ }

    " NerdTree
    " Files and directories to ignore
    let NERDTreeIgnore=[
        \'\~$',
        \'build$',
        \'dist$',
        \'\.DS_Store$',
        \'\.egg$',
        \'\.egg-info$',
        \'\.git',
        \'\.la$',
        \'\.lo$',
        \'\.\~lock.*#$',
        \'\.mo$',
        \'\.o$',
        \'\.pyc$',
        \'\.pyo$',
        \'__pycache__$',
        \'\.ropepropject$',
        \'\.svn$',
        \'\.tags$'
    \]
    let NERDTreeShowHidden=1

    " Pymode
    let python_highlight_all = 1
    let g:pymode_lint_hold = 0
    let g:pymode_syntax_builtin_objs = 0
    let g:pymode_syntax_builtin_funcs = 1
    let g:pymode_rope_goto_def_newwin = "new"
    let g:pymode_syntax_print_as_function = 1
    "" Extras
    let g:pymode_doc = 1
    let g:pymode_run_key = '<leader>r'
    let g:pymode_rope_vim_completion = 1
    let g:pymode_rope_enable_autoimport = 1
    let g:pymode_rope_auto_project = 1
    let g:pymode_rope_guess_project = 0
    let g:pymode_folding = 1
    let g:pymode_syntax_all = 1
    let g:pymode_motion = 1
    let g:pymode_virtualenv = 1
    " let g:SuperTabDefaultCompletionType = "context"


    " Vim Powerline
    set laststatus=2
    
    " CTRLP
    " let g:ctrlp_max_height = 30

    " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>ga :Gwrite<CR>
    nnoremap <leader>gc :Gcommit %<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gl :Glog<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gr :Gremove<CR>
    nnoremap <leader>go :Gread<CR>
    nnoremap <leader>gpl :Git pull origin master<CR>
    nnoremap <leader>gpp :Git push<CR>
    nnoremap <leader>gpm :Git push origin master<CR>

    noremap <F5> :emenu G.<TAB>
    menu G.Status :Gstatus<CR>
    menu G.Diff :Gdiff<CR>
    menu G.Commit :Gcommit %<CR>
    menu G.Checkout :Gread<CR>
    menu G.Remove :Gremove<CR>
    menu G.Move :Gmove<CR>
    menu G.Log :Glog<CR>
    menu G.Blame :Gblame<CR>
    " 


    " VimWiki
    " let g:vimwiki_folding = 1
    " let g:vimwiki_fold_lists = 1
    " let g:vimwiki_list = [
    "   \ {"path": "~/Dropbox/wiki"},
    "   \ {"path": "~/Dropbox/wiki/english"}
    " \ ]
    " nmap <leader>wv <Plug>VimwikiIndex

" }}}


" Hot keys {{{
" =========

    " Insert Mode {{{
    " -----------
        
        " Ctrl+V in insert mode calls ctrl+v in normal mode
        imap <C-V> <Esc><C-v>a
    " }}}

    " Normal Mode {{{
    " -----------

        " Ctrl+V in normal mode pastes the clipboard contents under the cursor
        nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
        " Nice scrolling if linewrap
        noremap j gj
        noremap k gk

        " Toggle Paste Mode
        noremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>
        " noremap <F2> :set invpaste<CR>:set paste?<CR>
        set pastetoggle=<F2>

        " Don't jump on star, only highlight
        nnoremap * *N

        " Split line in current position of cursor
        noremap <S-O>   i<CR><ESC>

        " Get rid of highlight from search
        noremap <leader><space> :nohls<CR>

        " Unfold
        noremap <space> za

        " Selet all
        map vA ggVG

        " Close cwindow
        nnoremap <silent> <leader>ll :ccl<CR>

        " Quickfix fast navigation
        nnoremap <silent> <leader>nn :cwindow<CR>:cn<CR>
        nnoremap <silent> <leader>pp :cwindow<CR>:cp<CR>

        " Window commands
        nnoremap <silent> <leader>j <c-w>j
        nnoremap <silent> <leader>k <c-w>k
        nnoremap <silent> <leader>l <c-w>l
        nnoremap <silent> <leader>h <c-w>h

        nnoremap <silent> <c-j> <c-w>j
        nnoremap <silent> <c-k> <c-w>k
        nnoremap <silent> <c-l> <c-w>l
        nnoremap <silent> <c-h> <c-w>h

        nnoremap <silent> <leader>cw :close<CR>

        " Buffer Commands
        noremap <silent> <leader>bp :bp<CR>
        noremap <silent> <leader>bn :bn<CR>
        noremap <silent> <leader>ww :w<CR>
        noremap <silent> <leader>bd :bd<CR>
        noremap <silent> <leader>ls :Bufferlist<CR>

        " Delete all buffers
        nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<CR>

        " Search the file for word under the cursor
        nnoremap <silent> <leader>gw :call rc#RGrep()<CR>

        " New Tab
        call rc#Map_ex_cmd("<C-W>t", ":tabnew")
        " Go to first tab
        call rc#Map_ex_cmd("<A-UP>", ":tabfirst")
        " Go to last tab
        call rc#Map_ex_cmd("<A-DOWN>", ":tablast")
        " Go to next tab
        call rc#Map_ex_cmd("<A-RIGHT>", ":tabnext")
        " Go to previous tab
        call rc#Map_ex_cmd("<A-LEFT>", ":tabprevious")

        " Tab Navigation
        map <A-1> 1gt
        map <A-2> 2gt
        map <A-3> 3gt
        map <A-4> 4gt
        map <A-5> 5gt
        map <A-6> 6gt
        map <A-7> 7gt
        map <A-8> 8gt
        map <A-9> 9gt

        " NerdTree Keys
        call rc#Map_ex_cmd("<F4>", "NERDTreeToggle")
        nnoremap <silent> <leader>f :NERDTreeFind<CR>
        
        " Toggle Tagbar
        call rc#Map_ex_cmd("<F3>", "TagbarToggle")
        call rc#Toggle_option("<F6>", "list")
        call rc#Toggle_option("<F7>", "wrap")

        " Close files
        call rc#Map_ex_cmd("<F10>", "qa")
        call rc#Map_ex_cmd("<S-F10>", "qa!")

        " Session commands
        nnoremap <leader>ss :call rc#SessionInput('Save')<CR>
        nnoremap <leader>sr :call rc#SessionInput('Read')<CR>
        nnoremap <leader>sl :call rc#SessionRead('last')<CR>

    " }}}


    " Command Mode {{{
    " ------------

        " Allow command line editing a la emacs
        cnoremap <C-A> <Home>
        cnoremap <C-B> <Left>
        cnoremap <C-E> <End>
        cnoremap <C-F> <Right>
        cnoremap <C-N> <Down>
        cnoremap <C-P> <Up>

        " Use w!! to write as sudo
        cmap w!! w !sudo tee % >/dev/null

    " }}}

    " Visual Mode {{{
    " -----------
        " Ctrl+y from visual mode copies to the X clipboard
        vmap <C-y> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
    " }}}

" }}}


" GUI Settings {{{
" ============

    if has("gui_running")
        set guioptions=agimP
        set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10
    endif

" }}}

" Local Settings
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif

" Project Settings {{{
" ================

    " Enables reading .vimrc, .exrc and .gvimrc in current directory
    set exrc

    " Must go last (see :help 'secure'.)
    set secure

