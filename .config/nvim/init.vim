let mapleader =","


if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'vim-scripts/taglist.vim'

Plug 'xuhdev/vim-latex-live-preview'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
" Plug 'ap/vim-css-color'
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'reedes/vim-pencil'
Plug 'takac/vim-hardtime'
Plug 'universal-ctags/ctags'
call plug#end()
" colorscheme gruvbox
let mapleader = " "
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
set bg=dark
" map <leader>b :bp<CR>
noremap <leader>z :TlistToggle<CR>
" TeX preview engine
let g:livepreview_previewer = 'zathura'

" vim pencil for md and tex
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType tex         call pencil#init()
augroup END

" tab switching
" noremap <tab> :tabn<CR>
:nnoremap <tab> :bnext<CR>
" make gf add to buffer
:map gf :e <cfile><CR>
" jump to def in split window
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
let Tlist_GainFocus_On_ToggleOpen = 1
autocmd FileType nerdtree let b:NERDTreeZoomed = 1 | wincmd |
" start nerdtree on empty buffer
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" vim markdown settings
" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	" syntax on
	set encoding=utf-8
	" set number relativenumber
" fzf, baby
map <leader>f :Files<CR>
map <leader>x :Buffers<CR>

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>g :Goyo \| set linebreak<CR>

"spellcheck
	 map <leader>s :setlocal spell! spelllang=en_us<CR>
"autonote thing, see scripts
	autocmd BufWritePost *note-*.md silent !buildNote %:p
" Splits open at the bottom and right, which is non-stupid, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	map <leader>t :NERDTreeToggle<CR>
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l


" Open my bibliography file in split
	" map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| :silent !compiler <c-r>%<CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex
" file.
" also and cleans out the build files of ABSTRACT.*

	autocmd VimLeave *.tex !texclear %
	autocmd VimLeave *.tex !texclear ABSTRACT.tex

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
