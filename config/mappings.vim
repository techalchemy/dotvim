let mapleader = ','



" F key mappings {{{
	nnoremap <silent> <F2> 	:set paste!<CR>
	call rc#Map_ex_cmd("<F3>", "CommandT")
    call rc#Map_ex_cmd("<F4>", "NERDTreeToggle")
	noremap <F5> :emenu G.<TAB>
	    menu G.Status :Gstatus<CR>
	    menu G.Diff :Gdiff<CR>
	    menu G.Commit :Gcommit %<CR>
	    menu G.Checkout :Gread<CR>
	    menu G.Remove :Gremove<CR>
	    menu G.Move :Gmove<CR>
	    menu G.Log :Glog<CR>
	    menu G.Blame :Gblame<CR>
	nnoremap <silent> <F6> 	:TagbarToggle<CR>
	nnoremap <silent> <F7> 	:CtrlPBuffer<CR>
	nnoremap <silent> <F8> 	:CtrlP<CR>
	nnoremap <silent> <F9> 	:CtrlPCurFile<CR>
	nnoremap <silent> <F10> :NERDTreeToggle<CR>

	" call rc#Toggle_option("<F6>", "list")
	" call rc#Toggle_option("<F7>", "wrap")

	" Close files
	" call rc#Map_ex_cmd("<F10>", "qa")
	" call rc#Map_ex_cmd("<S-F10>", "qa!")
" }}}

" Fugitive {{{
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
" }}}

" Session Control {{{
	nnoremap <leader>ss :call rc#SessionInput('Save')<CR>
	nnoremap <leader>sr :call rc#SessionInput('Read')<CR>
	nnoremap <leader>sl :call rc#SessionRead('last')<CR>
" }}}

" Paste {{{
	" Ctrl+V in normal mode pastes the clipboard contents under the cursor
	nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

	" Ctrl+V in insert mode calls ctrl+v in normal mode
	imap <C-V> <Esc><C-v>a
	inoremap jj <Esc>

	noremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>
	" Get rid of highlight from search
	noremap <leader><space> :nohls<CR>

	" Ctrl+y from visual mode copies to the X clipboard
	vmap <C-y> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>

	" Re-indent pasted text {{{
		nnoremap <Leader>p p'[v']=
		nnoremap <Leader>P P'[v']=
	" }}}
" }}}

" Formatting {{{
	" Unfold
	noremap <space> za

	" Selet all
	map vA ggVG

	" Don't jump on star, only highlight
	nnoremap * *N

	" Split line in current position of cursor
	noremap <S-O>   i<CR><ESC>

	" Search the file for word under the cursor
	nnoremap <silent> <leader>gw :call rc#RGrep()<CR>
" }}}

" Window Management {{{
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


" Buffer Commands {{{
	noremap <silent> <leader>bp :bp<CR>
	noremap <silent> <leader>bn :bn<CR>
	noremap <silent> <leader>ww :w<CR>
	noremap <silent> <leader>bd :bd<CR>
	noremap <silent> <leader>ls :Bufferlist<CR>

	" Delete all buffers
	nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<CR>	
" }}}

" Tabbing {{{
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
" }}}