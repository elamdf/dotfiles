
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
    Plug 'vim-scripts/taglist.vim'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/goyo.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'bling/vim-airline'
    Plug 'tpope/vim-commentary'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'junegunn/fzf.vim'
    Plug 'dense-analysis/ale'
    Plug 'reedes/vim-pencil'
call plug#end()

 let mapleader = " "
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
 noremap <tab> :tabn<CR>
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


" set go=a
set mouse=a
" set nohlsearch
set clipboard+=unnamedplus
let Tlist_GainFocus_On_ToggleOpen = 1
" " vim markdown settings
" " Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number
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

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l


" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| :silent !compiler <c-r>%<CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file
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
