if ! has('gui_running') && $TERM =~# 'screen-256color'
	" Set colorscheme {{{
		set background=dark
		set t_Co=256            " set 256 colors
		let g:solarized_termcolors=256
		let g:solarized_contrast="high"
		let g:solarized_termtrans=1
		let g:molokai_original=0
		let g:jellybeans_use_lowcolor_black=1
		" colo distinguished
		colo jellybeans
	" }}}
	" Instantly leave insert mode when pressing <Esc> {{{
		set ttimeoutlen=10
		augroup FastEscape
			autocmd!

			au InsertEnter * set timeoutlen=0
			au InsertLeave * set timeoutlen=1000
		augroup END
	" }}}
	" Change cursor color in insert mode {{{
		let &t_SI = ']50;CustomCursorColor=#89b6e2;BlinkingCursorEnabled=true'
		let &t_EI = ']50;CustomCursorColor=#dd4010;BlinkingCursorEnabled=false'
	" }}}
	" Use custom fillchars/listchars/showbreak icons {{{
		set list
		set fillchars=vert:│,fold:┄,diff:╱
		set listchars=tab:⋮\ ,trail:⌴,eol:·,precedes:◂,extends:▸
		set showbreak=↪
	" }}}
endif