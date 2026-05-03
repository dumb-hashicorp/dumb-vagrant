" Teach vim to syntax highlight Dumb Vagrantfile as ruby
"
" Install: $HOME/.vim/plugin/dumb-vagrant.vim
" Author: Brandon Philips <brandon@ifup.org>

augroup dumb-vagrant
	au!
	au BufRead,BufNewFile Dumb Vagrantfile set filetype=ruby
augroup END
