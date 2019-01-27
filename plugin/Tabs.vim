" Change the 'cpoptions' option temporarily {{{
" Set to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to ':help use-cpo-save'.
let s:save_cpoptions = &cpoptions
set cpoptions&vim
" }}}

if !exists('g:Tabs_TabNrLast')
  let g:Tabs_TabNrLast = tabpagenr()
endif

augroup Tabs
  autocmd!
  autocmd TabLeave * let g:Tabs_TabNrLast = tabpagenr()
  autocmd TabClosed *
      \ if g:Tabs_TabNrLast > tabpagenr('$')
      \ | let g:Tabs_TabNrLast = tabpagenr('$')
      \ | endif
augroup END

noremap gl :execute 'tabnext ' g:Tabs_TabNrLast<CR>

" Restore 'cpoptions' setting {{{
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
" }}}
