"""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""" NEOVIM CONFIG """""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""

" TODO Get inspired by https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L151-L187 for plugin configs

let g:mapleader = "\<space>"
let g:maplocalleader = ","

" {{{ Installing vim-plug if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" }}}

""" {{{1 Plugins
" ====================================================================
call plug#begin('~/.config/nvim/plugged')

" {{{2 Appearance
" ====================================================================
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" {{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tmuxline#enabled = 0
  let g:tmuxline_preset = 'full'
" }}}
" Plug 'itchyny/lightline.vim'
" " {{{
"   " TODO Integration with neomake (and possibly others)
"   " TODO Beautiful bar
"   " TODO Python virtualenv
"   " TODO Test
"   " TODO Ongoing process status
"   " TODO Quickfix content
"   " TODO Number of buffer
"   " TODO Git info
"   " TODO Tag navigation
"   let g:lightline = {
"         \ 'colorscheme': 'wombat',
"         \ 'active': {
"         \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
"         \   'right': [ [ 'lineinfo' ], ['percent'], [ 'indentation', 'trailing', 'fileformat', 'fileencoding', 'filetype' ] ]
"         \ },
"         \ 'inactive': {
"         \   'left': [ [ 'mode_inactive', 'filename' ], [ 'fugitive' ] ]
"         \ },
"         \ 'component_function': {
"         \   'fugitive': 'LightLineFugitive',
"         \   'readonly': 'LightLineReadonly',
"         \   'modified': 'LightLineModified',
"         \   'fileformat': 'LightLineFileformat',
"         \   'filetype': 'LightLineFiletype',
"         \   'fileencoding': 'LightLineFileencoding',
"         \   'filename': 'LightLineFilename',
"         \   'mode': 'LightLineMode',
"         \   'mode_inactive': 'LightLineModeInactive'
"         \ },
"         \ 'component_expand': {
"         \   'trailing': 'TrailingSpaceWarning',
"         \   'indentation': 'MixedIndentSpaceWarning',
"         \ },
"         \ 'component_type': {
"         \   'trailing': 'warning',
"         \   'indentation': 'warning',
"         \ },
"         \ 'separator': { 'left': '⮀', 'right': '⮂' },
"         \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
"         \ }
"
"   function! LightLineModified()
"     return &ft =~ 'help\|nerdtree\|undotree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
"   endfunction
"
"   function! LightLineReadonly()
"     return &ft !~? 'help\|nerdtree\|undotree' && &readonly ? '⭤' : ''
"   endfunction
"
"   function! LightLineFugitive()
"     try
"       if &ft !~? 'nerdtree\|undotree' && exists('*fugitive#head')
"         let mark = '⭠ '
"         let _ = fugitive#head()
"         return strlen(_) ? mark._ : ''
"       endif
"     catch
"     endtry
"     return ''
"   endfunction
"
"   function! LightLineFilename()
"     return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
"           \ (&ft =~ 'nerdtree\|undotree' ? '' :
"           \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
"           \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
"   endfunction
"
"   function! LightLineFileformat()
"     " return winwidth(0) > 70 ? &fileformat : ''
"     return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
"   endfunction
"
"   function! LightLineFiletype()
"     " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
"     return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
"   endfunction
"
"   function! LightLineFileencoding()
"     return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
"   endfunction
"
"   function! LightLineMode()
"     let fname = expand('%:t')
"     return &ft =~ 'nerdtree' ? 'NERDTree':
"           \ &ft =~ 'undotree' ? 'UndoTree' :
"           \ winwidth(0) > 60 ? lightline#mode() : lightline#mode()[0]
"   endfunction
"
"   function! LightLineModeInactive()
"     let fname = expand('%:t')
"     return &ft == 'nerdtree' ? 'NERDTree':
"           \ &ft == 'undotree' ? 'UndoTree' : ''
"   endfunction
"
"   function! TrailingSpaceWarning()
"     if &ft =~ 'help' || winwidth(0) < 70 | return '' | endif
"     let l:trailing = search('\s$', 'nw')
"     return (l:trailing != 0) ? 'trailing[' . trailing . ']' : ''
"   endfunction
"
"   function! MixedIndentSpaceWarning()
"     if &ft =~'help' || winwidth(0) < 70 | return '' | endif
"     let l:tabs = search('^\t', 'nw')
"     let l:spaces = search('^ ', 'nw')
"     return (l:tabs != 0 && l:spaces != 0) ? 'mixed-indent[' . tabs . ']' : ''
"   endfunction
"
"   augroup ComponentExpand
"     autocmd!
"     autocmd CursorHold,BufWritePost,InsertLeave * call s:flags()
"   augroup END
"
"   function! s:flags()
"     if exists('#LightLine')
"       call TrailingSpaceWarning()
"       call MixedIndentSpaceWarning()
"       call lightline#update()
"     endif
"   endfunction
"
"   let g:tmuxline_preset = 'full'
" " }}}

Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
" {{{
  nnoremap <Leader>g :Goyo<CR>
  function! s:goyo_enter()
    if exists('$TMUX')
      silent !tmux resize-pane -Z
      silent !tmux set status off
    endif
    if &filetype == 'markdown' || &filetype == 'mkd' || &filetype == 'tex'
      Limelight
    endif
    set noshowmode
    set noshowcmd
    set nonumber
    set scrolloff=10
    NumbersDisable
    set norelativenumber
  endfunction

  function! s:goyo_leave()
    if exists('$TMUX')
      silent !tmux resize-pane -Z
      silent !tmux set status on
    endif
    Limelight!
    set showmode
    set showcmd
    set number
    set scrolloff=5
    NumbersEnable
  endfunction

  autocmd! User GoyoEnter
  autocmd! User GoyoLeave
  autocmd  User GoyoEnter nested call <SID>goyo_enter()
  autocmd  User GoyoLeave nested call <SID>goyo_leave()

  let g:goyo_width = 120
  let g:goyo_height = '60%'
" }}}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
" {{{
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_guifg = 'gray'
" }}}

Plug 'edkolev/tmuxline.vim'
Plug 'myusuf3/numbers.vim'
Plug 'junegunn/rainbow_parentheses.vim'
" {{{
  autocmd VimEnter * RainbowParentheses
" }}}
Plug 'szw/vim-maximizer'

" Plug 'KabbAmine/vCoolor.vim', {'for': ['css', 'sass']} " TODO

" Plug 'tomtom/quickfixsigns_vim' " TODO Visual indications in the quickfix window

" {{{2 Completion
" ====================================================================
Plug 'Shougo/deoplete.nvim'
" {{{
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  let g:deoplete#enable_at_startup = 1
  " inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  " disable autocomplete:
  let g:deoplete#disable_auto_complete = 1
  " Map complete to <C-Space>
  " inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
" }}}
" " Snippets
Plug 'SirVer/ultisnips'
" {{{
  inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
" {{{
  let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}

" {{{2 File navigation
" ====================================================================
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" {{{
  nnoremap <F10> :NERDTreeToggle<cr>
" }}}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'aufgang001/vim-nerdtree_plugin_open', {'on': 'NERDTreeToggle'}
" {{{
    let g:nerdtree_plugin_open_cmd = 'xdg-open'
" }}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_layout = { 'down': '~40%' }
  " nnoremap <silent> <LocalLeader><LocalLeader> :Buffers<CR>
  nnoremap <silent> <leader>p :Files<CR>
  nnoremap <silent> <leader>t :Tags<CR>
  nnoremap <silent> <leader><s-t> :BTags<CR>
  nnoremap <silent> <leader>f :Ag<CR>
" }}}
" Plug 'eugen0329/vim-esearch' " TODO

Plug 'vim-ctrlspace/vim-ctrlspace'
" {{{
  set hidden
  let g:airline_exclude_preview = 1
  set showtabline=0
  let g:CtrlSpaceDefaultMappingKey = ';'
  " if executable("ag")
  "   let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  " endif
" }}}

" Plug 'fmoralesc/vim-pad' " TODO
" {{{
  " let g:pad#default_format = "pandoc"
" }}}

" {{{2 Workflow
" ====================================================================
Plug 'kassio/neoterm'
" {{{
  let g:neoterm_position = 'horizontal'
  let g:neoterm_automap_keys = ',th'
  "
  nnoremap <silent> <s-f9> :TREPLSendFile<cr>
  nnoremap <silent> <f9> :TREPLSend<cr>
  vnoremap <silent> <f9> :TREPLSend<cr>
  "
  " Useful maps
  " hide/close terminal
  nnoremap <silent> <LocalLeader>tt :call neoterm#toggle()<cr>
  " clear terminal
  nnoremap <silent> <LocalLeader>tl :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> <LocalLeader>tc :call neoterm#kill()<cr>
" }}}
Plug 'janko-m/vim-test'
" {{{
  let test#strategy = "neoterm"
  " nmap <silent> <leader>t :TestNearest<CR>
  " nmap <silent> <leader>T :TestFile<CR>
  " nmap <silent> <leader>a :TestSuite<CR>
  " nmap <silent> <leader>l :TestLast<CR>
  " nmap <silent> <leader>g :TestVisit<CR>
" }}}

" Plug 'brettanomyces/nvim-editcommand' " TODO
" Plug 'bfredl/nvim-ipy' " TODO
" Plug 'jalvesaq/vimcmdline' " TODO

" {{{2 Text navigation
" ====================================================================
Plug 'kshenoy/vim-signature'
Plug 'edsono/vim-matchit'
" Plug 'Lokaltog/vim-easymotion' " TODO
" Plug 'justinmk/vim-sneak' " TODO
" Plug 'rhysd/clever-f.vim' " TODO
" Plug 'osyo-manga/vim-anzu' " TODO

" {{{2 Text manipulation
" ====================================================================
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'
Plug 'alvan/vim-closetag'
" {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
" }}}
Plug 'tomtom/tcomment_vim'
" {{{
  autocmd VimEnter * map gcc <c-_><c-_>
" }}}
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_nesting_quotes = ['"', '`']
  let delimitMate_expand_cr=1
  let delimitMate_expand_space=1
  au FileType xml,html,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"
" }}}
Plug 'terryma/vim-multiple-cursors'
Plug 'loremipsum', {'on': 'Loremipsum'}
Plug 'tpope/vim-endwise'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'gregsexton/MatchTag' " TODO
" Plug 'google/vim-codefmt' " TODO
" Plug 'AndrewRadev/sideways.vim' " TODO
" Plug 'AndrewRadev/switch.vim' " TODO
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'thinca/vim-qfreplace' " TODO

" {{{2 Text Objects
" ====================================================================
" Plug 'wellle/targets.vim' " TODO
" Plug 'kana/vim-operator-user' " TODO
" Plug 'kana/vim-textobj-user' " TODO
" Plug 'rhysd/conflict-marker.vim' " TODO
" Plug 'junegunn/vim-after-object' " TODO

" {{{2 Languages
" ====================================================================
Plug 'benekastah/neomake'
" {{{
  " TODO Make better linter with python
  autocmd! BufWritePost,BufEnter * Neomake
  " let g:neomake_python_enabled_makers = ['flake8', 'pylint']
  let g:neomake_ruby_rubocup_makers = {
        \ 'args': ['--rails']
        \ }
" }}}

" Plug 'sheerun/vim-polyglot' " TODO

Plug 'seebi/semweb.vim', {'for': ['sparql', 'n3', 'tex']}

Plug 'klen/python-mode', {'for': 'python'}
" {{{
  " TODO Replace python-mode by pythondoc, python-syntax, jedi-vim, vim-virtualenv...
  let g:pymode_run = 0
  let g:pymode_warnings = 0
  let g:pymode_rope = 0
  let g:pymode_lint = 0
  let g:pymode_options_max_line_length = 100
  let g:pymode_virtualenv = 1
  " let g:pymode_lint_write = 0
  " let g:pymode_lint_checker = "pylint
  " let g:pymode_lint_ignore = "C0103"
  " let g:pymode_lint_cwindow = 0
" }}}
" Plug 'davidhalter/jedi-vim', {'for': 'python'}
" " {{{
"   let g:jedi#popup_on_dot = 0
" " }}}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
" " {{{
"   autocmd FileType python setlocal completeopt-=preview
" " }}}
" Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}

Plug 'othree/html5.vim', {'for': ['html', 'eruby', 'html.handlebars', 'html.mustache']}
Plug 'mattn/emmet-vim', {'for': ['html', 'eruby', 'html.handlebars', 'html.mustache']}
" {{{
  let g:use_emmet_complete_tag = 1
" }}}
Plug 'ap/vim-css-color', {'for': ['css', 'sass', 'scss']}
Plug 'hail2u/vim-css3-syntax', {'for': ['css', 'sass', 'scss']}
" Plug 'Valloric/MatchTagAlways', {'for': ['html', 'eruby', 'html.handlebars', 'html.mustache']}
Plug 'jaxbot/browserlink.vim', {'for': ['html', 'eruby', 'javascript', 'css']}
" {{{
  " au InsertLeave *.html :BLReloadPage
  " au InsertLeave *.css :BLReloadCSS
" }}}

Plug 'ekalinin/Dockerfile.vim'
" Plug 'jelera/vim-javascript-syntax', {'for': 'jst'} " TODO
Plug 'evidens/vim-jst'
" Plug 'mustache/vim-mustache-handlebars', {'for': ['html.handlebars', 'html.mustache']} " TODO
" Plug 'marijnh/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
" Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'} " TODO
" Plug 'ahayman/vim-nodejs-complete', {'for': 'javascript'} " TODO
" Plug 'moll/vim-node', {'for': 'javascript'} " TODO

Plug 'vim-ruby/vim-ruby'
Plug 'vim-utils/vim-ruby-fold'
Plug 'tpope/vim-bundler'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-rails'
Plug 'jgdavey/vim-blockle'
" {{{
augroup ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" }}}

" Plug 'elzr/vim-json', {'for': 'json'} " TODO
" {{{
"   let g:vim_json_syntax_conceal = 0
" }}}

" Plug 'chase/vim-ansible-yaml' " TODO

" {{{2 Text documents
" ====================================================================
Plug 'lervag/vimtex'
" {{{
  let g:tex_flavor = "latex"
  augroup latex
    autocmd!
    autocmd FileType tex nnoremap <buffer><F5> :VimtexCompile<CR>
    autocmd FileType tex map <silent> <buffer><F8> :call vimtex#latexmk#errors_open(0)<CR>
    autocmd FileType tex setlocal spell
    autocmd FileType tex set foldlevel=1

    autocmd FileType tex let b:endwise_words = '\\begin{\zs[a-zA-Z0-9*]*\ze}' " ignored
    autocmd FileType tex let b:endwise_pattern = '\\begin{\zs[a-zA-Z0-9*]*\ze}'
    autocmd FileType tex let b:endwise_addition = '\\end{&}'
    autocmd FileType tex let b:endwise_syngroups = 'texBeginEndName'
  augroup END

  " let g:vimtex_fold_enabled = 1
  let g:vimtex_syntax_minted = [
        \ {'lang' : 'python3', 'syntax': 'python'},
        \ {'lang' : 'numpy', 'syntax': 'python'},
        \ {'lang' : 'python'},
        \ {'lang' : 'n3'}
        \]
" }}}
Plug 'matze/vim-tex-fold'
" {{{
  let g:tex_fold_additional_envs = ['algorithm', 'listing']
" }}}
" Plug 'plasticboy/vim-markdown' " TODO
" {{{
"   let g:vim_markdown_math=1
"   au FileType mkd,markdown nnoremap <buffer> <localleader>l :Toc<CR>
" }}}
" Plug 'vim-pandoc/vim-pandoc' " TODO
" {{{
  " let g:pandoc#hypertext#create_if_no_alternates_exists = 1
  " let g:pandoc#hypertext#open_cmd = 'edit'
" }}}
" Plug 'vim-pandoc/vim-pandoc-syntax' " TODO
" Plug 'vim-markdown-composer' " TODO
Plug 'RomainEndelin/vimoutliner', {'for': 'votl'}
" {{{
  au FileType votl setlocal ts=2 sts=2 sw=2
" }}}
" Plug 'reedes/vim-litecorrect' " TODO
" Plug 'reedes/vim-lexical'
" {{{
  " augroup lexical
  "   autocmd!
  "   autocmd FileType tex call lexical#init()
  " augroup END
  " let g:lexical#dictionary = ['/usr/share/dict/words',]
  " let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add',]
  " let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt',]
" }}}
Plug 'reedes/vim-wordy'
Plug 'rhysd/vim-grammarous'
Plug 'LanguageTool'
" {{{
  let g:languagetool_jar='/usr/local/lib/LanguageTool-3.2/languagetool.jar'
" }}}

" {{{2 Git
" ====================================================================
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-heroku'
" Plug 'gregsexton/gitv'
" Plug 'tpope/vim-rhubarb' " TODO
" Plug 'esneider/YUNOcommit.vim' " TODO
" Plug 'idanarye/vim-merginal' " TODO

" {{{2 Utility
" ====================================================================
Plug 'christoomey/vim-tmux-navigator'
" {{{
  nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
" }}}
Plug 'tpope/vim-eunuch'
Plug 'mbbill/undotree'
" {{{
  nnoremap <F6> :UndotreeToggle<cr>
" }}}
" Plug 'Majutsushi/tagbar'
" " {{{
"   nnoremap <F8> :TagbarToggle<cr>
"   let g:tagbar_type_ruby = {
"       \ 'kinds' : [
"           \ 'm:modules',
"           \ 'c:classes',
"           \ 'd:describes',
"           \ 'C:contexts',
"           \ 'f:methods',
"           \ 'F:singleton methods'
"       \ ]
"   \ }
"   let g:tagbar_type_css = {
"   \ 'ctagstype' : 'Css',
"       \ 'kinds'     : [
"           \ 'c:classes',
"           \ 's:selectors',
"           \ 'i:identities'
"       \ ]
"   \ }
" " }}}
" Plug 'cazador481/fakeclip.neovim' " TODO
" Plug '907th/vim-auto-save' " TODO
" Plug 'milkypostman/vim-togglelist' " TODO
" Plug 'lyokha/vim-xkbswitch' " TODO
" Plug 'ludovicchabant/vim-gutentags' " TODO
" {{{
"   nmap <F8> :TagbarToggle<CR>
" }}}
" Plug 'mhinz/vim-startify' " TODO
" Plug 'vim-scripts/YankRing.vim' " TODO

call plug#end()

""" {{{1 Options
" ====================================================================

" TODO Check timeout
" set ttimeout
set ttimeoutlen=-1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" {{{
let g:terminal_color_0  = "#2b2b2b"
let g:terminal_color_1  = "#da4939"
let g:terminal_color_2  = "#a5c261"
let g:terminal_color_3  = "#ffc66d"
let g:terminal_color_4  = "#6d9cbe"
let g:terminal_color_5  = "#b6b3eb"
let g:terminal_color_6  = "#519f50"
let g:terminal_color_7  = "#e6e1dc"
let g:terminal_color_8  = "#5a647e"
let g:terminal_color_9  = "#da4939"
let g:terminal_color_10 = "#a5c261"
let g:terminal_color_11 = "#ffc66d"
let g:terminal_color_12 = "#6d9cbe"
let g:terminal_color_13 = "#b6b3eb"
let g:terminal_color_14 = "#519f50"
let g:terminal_color_15 = "#f9f7f3"
let g:terminal_color_16 = "#cc7833"
let g:terminal_color_17 = "#bc9458"
let g:terminal_color_18 = "#272935"
let g:terminal_color_19 = "#3a4055"
let g:terminal_color_20 = "#d4cfc9"
" }}}

set background=dark
colorscheme base16-railscasts
" colorscheme gruvbox

set pastetoggle=<F5>
set clipboard=unnamed,unnamedplus

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround

set foldmethod=syntax

nmap Q <Nop>

set splitright
set splitbelow

set scrolloff=5

set wildmenu
set wildmode=list:longest,full

set wildignore+=*.swp
set wildignore+=*.jpg,*.bmp,*.gif
set wildignore+=*.pdf
set wildignore+=*.pyc
set wildignore+=*.o,*.obj,*.dll,*.exe
set wildignore+=*.aux,*.out,*.toc

set ruler

set ignorecase
set smartcase

" set showmatch

nnoremap \<space> :noh<cr>

vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

tnoremap <Leader>e <C-\><C-n>

set number
nnoremap <F2> :NumbersToggle<CR>
let g:numbers_exclude = ['unite', 'vimfiler', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

noremap <Leader><Leader> <C-^>

" only smart break at the break characters (. , :)
set linebreak

set formatoptions=qrcnlj1

inoremap jj <ESC>

" When pressing Space-Enter, going from:
"   <div>|</div>
" towards:
"   <div>
"     |
"   </div>
nnoremap <leader><CR> i<CR><C-o>==<C-o>O

augroup python
    au FileType python setlocal textwidth=80
    au FileType python setlocal colorcolumn=80
augroup END

" autocmd Filetype vim,ruby,eruby,html,html.handlebars,jst,javascript,json,css setlocal ts=2 sw=2 expandtab

augroup omnifuncs
  autocmd!
  " autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
augroup end

" vim: set sw=2 ts=2 et foldlevel=1 foldmethod=marker:
