set number
set relativenumber
colorscheme slate
set tabstop=2
set shiftwidth=2
set laststatus=2
set noshowmode
set statusline=

let g:currentmode={
	\ 'n' :	 'NORMAL',
	\ 'i' :	 'INSERT',
	\ 'v' :	 'VISUAL',
	\ 'V' :	 'V-LINE',
	\ 'R' :	 'R ',
	\ 'c' :	 'COMMAND -> ',
\}


set statusline+=\ %#NormalC#%{(mode()=='n')?'\ normal\ ':''} 
set statusline+=\ %#VisualC#%{(mode()=='v')?'\ VISUAL\ ':''} 
set statusline+=\ %#InsertC#%{(mode()=='i')?'\ INSERT\ ':''} 
"set statusline+=\ %#InsertC#%{(mode()=='i')?'\ INSERT\ ':''} 
set statusline+=%#Filename#
set statusline+=\ %f
set statusline+=\ %m

" cursor lines and line totals
set statusline+=\ [%l/%L]


" switching between panes
:map <C-h> <C-w>h
:map <C-l> <C-w>l
:map <C-j> <C-w>j
:map <C-k> <C-w>k
