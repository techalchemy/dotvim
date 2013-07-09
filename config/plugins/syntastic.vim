let g:syntastic_enable_signs = 0
let g:syntastic_mode_map = {
	\ 'mode': 'active',
	\ 'passive_filetypes': ['c', 'javascript'],
	\ }

" Configure flake8 syntax checker
"
" I'm using tabs for indentation and spaces for alignment in Python code, and
" I'd like flake8 to not warn me about that (even though it "violates" PEP-8).
"
" W191: Tabs for indentation
" E501: Too long line
let g:syntastic_python_flake8_args = '--ignore=E501,E121,E122,E123,E128'

" let g:syntastic_python_checkers = ['flake8', 'pylint']
" let g:syntasic_check_on_open = 0
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_style_warning_symbol='☔'
" let g:syntastic_style_error_symbol='⚑'
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_mode_map = { 'mode': 'active',
                " \ 'active_filetypes': [],
                " \ 'passive_filetypes': ['java'] }