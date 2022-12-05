function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction

function! s:MaybeEnterDirectory(file)
	if a:file != '' && isdirectory(a:file)
		let dir = a:file
		exe "cd ".dir
		if filereadable('_project.vim')
			source _project.vim
			echo "Loaded project file"
		endif
	endif
endfunction

augroup filetypes
	autocmd!
	autocmd BufRead,BufNewFile *.md setfiletype markdown
	autocmd BufRead,BufNewFile *.tpl set filetype=cpp
augroup end

augroup rust
	autocmd!
	autocmd BufRead,BufNewFile *.rs set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
augroup end

augroup maybe_enter_directory
	autocmd!
	autocmd BufEnter,VimEnter * call s:MaybeEnterDirectory(expand("<amatch>"))
augroup end

augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup end

" exclude quickfix buffers from :bnext and :bprev
augroup qf
	autocmd!
	autocmd FileType qf set nobuflisted
augroup END

" exclude terminal from :bnext and :bprev
" augroup term
"     autocmd!
"     autocmd TermOpen * setlocal nobuflisted
" augroup END

