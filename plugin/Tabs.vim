" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to ':help use-cpo-save'.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

if !exists('g:Tabs_History')
  let g:Tabs_History = [tabpagenr()]
endif

augroup Tabs
  autocmd!
  autocmd TabEnter * call s:TabEnter()
  autocmd TabNew * call s:TabNew()
  autocmd TabClosed * call s:TabClosed()
augroup END

function! s:TabNew() "{{{
  " Inrease the number of the tab page behined the created one by 1.
  for i in range(len(g:Tabs_History))
    if g:Tabs_History[i] >= tabpagenr()
      let l:subsitute = g:Tabs_History[i] + 1
      call remove(g:Tabs_History, i)
      call insert(g:Tabs_History, l:subsitute, i)
    endif
  endfor
endfunction "}}}

function! s:TabClosed() "{{{
  " Derease the number of the tab page behined the closed one by 1.
  for i in range(len(g:Tabs_History))
    if g:Tabs_History[i] > tabpagenr()
      let l:subsitute = g:Tabs_History[i] - 1
      call remove(g:Tabs_History, i)
      call insert(g:Tabs_History, l:subsitute, i)
    endif
  endfor
endfunction "}}}

function! s:TabEnter() "{{{
  " Remove duplicated history items of current tab page number.
  let i = 0
  while i < len(g:Tabs_History)
    if g:Tabs_History[i] == tabpagenr()
      call remove(g:Tabs_History, i)
    endif
    let i += 1
  endwhile
  call insert(g:Tabs_History, tabpagenr())
endfunction "}}}

function! s:GoToLastTab() "{{{
endfunction "}}}

noremap <silent> gl :<C-U>execute 'tabnext '
    \ g:Tabs_History[min([len(g:Tabs_History) - 1, v:count1])]<CR>

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
