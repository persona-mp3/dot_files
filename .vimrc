let mapleader = " "
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set smartcase
set smartindent
set autoindent
set noswapfile

filetype plugin indent on

set termguicolors

" In .vimrc
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

noremap <leader>w :w<CR>
noremap <leader>q :qa!<CR>
noremap <leader>ww :wa<CR>
noremap <leader>so :source ~/.vimrc<CR>
noremap <leader>x :bdelete<CR>
noremap <leader>g :grep<space>
noremap ]q :cnext<CR>

colorscheme vague

set nowrap
autocmd FileType markdown,text setlocal wrap

set laststatus=2
" set statusline=
" set statusline+=\ %f                    " filename
" set statusline+=\ %m                    " modified flag [+]
" set statusline+=\ %r                    " readonly flag [RO]
" set statusline+=%=                      " right-align everything after this
" set statusline+=\ %y                    " filetype [python]
" set statusline+=\ %l:%c                 " line:column
" set statusline+=\ %p%%                  " percentage through file

let $FZF_DEFAULT_OPTS = '--style minimal  '
" let g:fzf_layout = { 'down': '80%' }
let g:fzf_layout = { 'window': { 'width': 0.90, 'height': 0.90 } }

noremap <leader>t :vertical terminal<CR>
noremap <leader>ff :Files<CR>	
noremap <leader>fb :Buffers<CR>
noremap <leader>sr :RG<CR>

