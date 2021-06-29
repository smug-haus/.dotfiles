runtime! debian.vim
set novisualbell
syntax on
color peachpuff
set background=dark
filetype indent plugin on
set number relativenumber 
set softtabstop=2 shiftwidth=2
set autoindent
set expandtab

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
