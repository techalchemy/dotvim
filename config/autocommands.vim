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