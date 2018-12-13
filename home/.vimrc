" ~/.vimrc

" Load Vundle for plugins:
	set nocompatible              " be iMproved, required
	filetype off                  " required

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	"Plugins"
	Plugin 'godlygeek/tabular'
	Plugin 'plasticboy/vim-markdown'	
	Plugin 'rhysd/vim-grammarous'
	"End Plugins"
	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line


" Some basics:
	syntax on	
	set encoding=utf-8
	"set autoindent

" Line numbers
	set number
	set relativenumber
	"set norelativenumber  " turn relative line numbers off
	"set relativenumber!   " toggle relative line numbers

"" Binding ""
" Disable Arrow keys in Escape mode
	map <up> <nop>
	map <down> <nop>
	map <left> <nop>
	map <right> <nop>

" Disable Arrow keys in Insert mode
	imap <up> <nop>
	imap <down> <nop>
	imap <left> <nop>
	imap <right> <nop>
"" Clipboard ""
	"set clipboard=unnamedplus " clipboard as default register
	noremap <Leader>y "*y
	noremap <Leader>p "*p
	noremap <Leader>Y "+y
	noremap <Leader>P "+p

" Copy selected text to system clipboard (requires xclip installed):
	vnoremap <C-c> "cy<esc>:!echo -n '<C-R>c' \|<space>xclip<CR><enter>

