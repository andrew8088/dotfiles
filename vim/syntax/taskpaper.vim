" Vim syntax file
" Language: Taskpaper
" Maintainer: Andrew Burgess
" Latest Revision: 21 April 2016

if exists("b:current_syntax")
    finish
endif

syntax match taskpaperProject "^.*:$"
syntax match taskpaperDone "^.*@done.*$"
syntax match taskpaperNext "^.*@next.*$"
syntax match taskpaperTag "@\w*"

let b:current_syntax = "taskpaper"

hi def link taskpaperProject Statement
hi def link taskpaperDone PreProc
hi def link taskpaperNext Statement
hi def link taskpaperTag Type
