"""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""" NEOVIM CONFIG """""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""

" TODO Get inspired by https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L151-L187 for plugin configs

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

Plug 'freeo/vim-kalisi'

" Plug 'ryanoasis/vim-devicons' " TODO Beaufiful icons

Plug 'itchyny/lightline.vim'
" {{{
  " TODO Integration with neomake (and possibly others)
  " TODO Integration with devicons
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ], ['percent'], [ 'indentation', 'trailing', 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'mode_inactive', 'filename' ], [ 'fugitive' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightLineFugitive',
        \   'readonly': 'LightLineReadonly',
        \   'modified': 'LightLineModified',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'filename': 'LightLineFilename',
        \   'mode': 'LightLineMode',
        \   'mode_inactive': 'LightLineModeInactive'
        \ },
        \ 'component_expand': {
        \   'trailing': 'TrailingSpaceWarning',
        \   'indentation': 'MixedIndentSpaceWarning',
        \ },
        \ 'component_type': {
        \   'trailing': 'warning',
        \   'indentation': 'warning',
        \ },
        \ 'separator': { 'left': '⮀', 'right': '⮂' },
        \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
        \ }

  function! LightLineModified()
    return &ft =~ 'help\|nerdtree\|undotree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightLineReadonly()
    return &ft !~? 'help\|nerdtree\|undotree' && &readonly ? '⭤' : ''
  endfunction

  function! LightLineFugitive()
    try
      if &ft !~? 'nerdtree\|undotree' && exists('*fugitive#head')
        let mark = '⭠ '
        let _ = fugitive#head()
        return strlen(_) ? mark._ : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
          \ (&ft =~ 'nerdtree\|undotree' ? '' :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! LightLineMode()
    let fname = expand('%:t')
    return &ft =~ 'nerdtree' ? 'NERDTree':
          \ &ft =~ 'undotree' ? 'UndoTree' :
          \ winwidth(0) > 60 ? lightline#mode() : lightline#mode()[0]
  endfunction

  function! LightLineModeInactive()
    let fname = expand('%:t')
    return &ft == 'nerdtree' ? 'NERDTree':
          \ &ft == 'undotree' ? 'UndoTree' : ''
  endfunction

  function! TrailingSpaceWarning()
    if &ft =~ 'help' || winwidth(0) < 70 | return '' | endif
    let l:trailing = search('\s$', 'nw')
    return (l:trailing != 0) ? 'trailing[' . trailing . ']' : ''
  endfunction

  function! MixedIndentSpaceWarning()
    if &ft =~'help' || winwidth(0) < 70 | return '' | endif
    let l:tabs = search('^\t', 'nw')
    let l:spaces = search('^ ', 'nw')
    return (l:tabs != 0 && l:spaces != 0) ? 'mixed-indent[' . tabs . ']' : ''
  endfunction

  augroup ComponentExpand
    autocmd!
    autocmd CursorHold,BufWritePost,InsertLeave * call s:flags()
  augroup END

  function! s:flags()
    if exists('#LightLine')
      call TrailingSpaceWarning()
      call MixedIndentSpaceWarning()
      call lightline#update()
    endif
  endfunction

  let g:tmuxline_preset = 'full'
" }}}

Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
" {{{
  nnoremap <Leader>g :Goyo<CR>
  function! s:goyo_enter()
    if exists('$TMUX')
      silent !tmux resize-pane -Z
      silent !tmux set status off
    endif
    if &filetype == 'markdown' || &filetype == 'mkd'
      Limelight
    endif
    set noshowmode
    set noshowcmd
    set nonumber
    set scrolloff=999
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
" }}}

Plug 'edkolev/tmuxline.vim'
Plug 'myusuf3/numbers.vim'
Plug 'junegunn/rainbow_parentheses.vim'
" {{{
  autocmd VimEnter * RainbowParentheses
" }}}
Plug 'szw/vim-maximizer'
" Plug 'roman/golden-ratio' " TODO Nice window spacing

" Plug 'tomtom/quickfixsigns_vim' " TODO Visual indications in the quickfix window

" {{{2 Completion
" ====================================================================
" Plug 'Shougo/deoplete.nvim' " TODO
" {{{
" let g:deoplete#enable_at_startup = 1
" " disable autocomplete
" let g:deoplete#disable_auto_complete = 1
" inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
" }}}
" " Snippets
" Plug 'SirVer/ultisnips' " TODO
" {{{
" inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}
" Plug 'honza/vim-snippets' " TODO

" {{{2 File navigation
" ====================================================================
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" {{{
  nnoremap <F10> :NERDTreeToggle<cr>
" }}}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_layout = { 'down': '~40%' }
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>p :Files<CR>
  nnoremap <silent> <leader>t :Tags<CR>
  nnoremap <silent> <leader><s-t> :BTags<CR>
  nnoremap <silent> <leader>f :Ag<CR>
" }}}

" Plug 'fmoralesc/vim-pad' " TODO
" {{{
  " let g:pad#default_format = "pandoc"
" }}}

" {{{2 Workflow
" ====================================================================
" Plug 'kassio/neoterm' " TODO
" Plug 'brettanomyces/nvim-editcommand' " TODO
" Plug 'janko-m/vim-test' " TODO
" Plug 'bfredl/nvim-ipy' " TODO
" Plug 'jalvesaq/vimcmdline' " TODO

" {{{2 Text navigation
" ====================================================================
" Plug 'Lokaltog/vim-easymotion' " TODO
" Plug 'justinmk/vim-sneak' " TODO
" Plug 'rhysd/clever-f.vim' " TODO
" Plug 'kristijanhusak/vim-multiple-cursors' " TODO
" Plug 'osyo-manga/vim-anzu' " TODO
" Plug 'kshenoy/vim-signature' " TODO

" {{{2 Text manipulation
" ====================================================================
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'junegunn/vim-easy-align'
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
" }}}
Plug 'loremipsum', {'on': 'Loremipsum'}
" Plug 'tpope/vim-endwise' " TODO
" Plug 'gregsexton/MatchTag' " TODO
" Plug 'docunext/closetag.vim' " TODO
" Plug 'tpope/vim-ragtag' " TODO
" Plug 'google/vim-codefmt' " TODO
" Plug 'AndrewRadev/sideways.vim' " TODO
" Plug 'AndrewRadev/switch.vim' " TODO
" Plug 'AndrewRadev/splitjoin.vim' " TODO
" Plug 'thinca/vim-qfreplace' " TODO

" {{{2 Text Objects
" ====================================================================
" Plug 'wellle/targets.vim' " TODO
" Plug 'kana/vim-operator-user' " TODO
" Plug 'kana/vim-textobj-user' " TODO
" Plug 'rhysd/conflict-marker.vim' " TODO

" {{{2 Languages
" ====================================================================
Plug 'benekastah/neomake', {'on': 'Neomake'}
" {{{
  " TODO Make better linter with python
  " autocmd! BufWritePost,BufEnter * Neomake
" }}}

" Plug 'sheerun/vim-polyglot' " TODO

Plug 'lervag/vimtex', {'for': ['tex', 'bib']}
" {{{
  augroup latex
    autocmd!
    autocmd FileType tex nnoremap <buffer><F5> :VimtexCompile<CR>
    autocmd FileType tex map <silent> <buffer><F8> :call vimtex#latexmk#errors_open(0)<CR>
  augroup END
" }}}
" Plug 'plasticboy/vim-markdown' " TODO
" {{{
"   let g:vim_markdown_math=1
"   au FileType mkd,markdown nnoremap <buffer> <localleader>l :Toc<CR>
" }}}
" Plug 'vim-pandoc/vim-pandoc' " TODO
" {{{
  let g:pandoc#hypertext#create_if_no_alternates_exists = 1
  let g:pandoc#hypertext#open_cmd = 'edit'
" }}}
" Plug 'vim-pandoc/vim-pandoc-syntax' " TODO
" Plug 'vim-markdown-composer' " TODO
Plug 'RomainEndelin/vimoutliner', {'for': 'votl'}
" {{{
  au FileType votl setlocal ts=2 sts=2 sw=2
" }}}

" Plug 'seebi/semweb.vim', {'for': ['sparql', 'n3']} " TODO

" Plug 'klen/python-mode', {'for': 'python'}
" {{{
  " TODO Replace python-mode by pythondoc, python-syntax, jedi-vim, vim-virtualenv...
  " let g:pymode_run = 0
  " let g:pymode_warnings = 0
  " let g:pymode_rope = 0
  " let g:pymode_lint_write = 0
  " " let g:pymode_run_key = '<leader>r'
  " " let g:pymode_syntax_slow_sync = 1
  " " let g:pymode_lint_checker = "pylint
  " let g:pymode_lint_ignore = "C0103"
  " let g:pymode_lint_cwindow = 0
  " " map <leader>j :RopeGotoDefinition<CR>
  " " map <leader>r :RopeRename<CR>
" }}}

" Plug 'othree/html5.vim', {'for': ['html', 'html.handlebars', 'html.mustache']} " TODO
" Plug 'mattn/emmet-vim', {'for': ['html', 'html.handlebars', 'html.mustache']} " TODO
" {{{
  " let g:use_emmet_complete_tag = 1
" }}}
" Plug 'jelera/vim-javascript-syntax', {'for': 'jst'} " TODO
" Plug 'evidens/vim-jst', {'for': 'jst'} " TODO
" Plug 'mustache/vim-mustache-handlebars', {'for': ['html.handlebars', 'html.mustache']} " TODO
" Plug 'marijnh/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
" Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'} " TODO
" Plug 'ahayman/vim-nodejs-complete', {'for': 'javascript'} " TODO
" Plug 'moll/vim-node', {'for': 'javascript'} " TODO

" Plug 'tpope/vim-rails' " TODO

" Plug 'elzr/vim-json', {'for': 'json'} " TODO
" {{{
"   let g:vim_json_syntax_conceal = 0
" }}}

" Plug 'chase/vim-ansible-yaml' " TODO

" {{{2 Git
" ====================================================================
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
" Plug 'tpope/vim-rhubarb' " TODO
" Plug 'esneider/YUNOcommit.vim' " TODO
" Plug 'idanarye/vim-merginal' " TODO

" {{{2 Utility
" ====================================================================
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-eunuch'
Plug 'mbbill/undotree'
" {{{
  nnoremap <F6> :UndotreeToggle<cr>
" }}}
" Plug 'cazador481/fakeclip.neovim' " TODO
" Plug '907th/vim-auto-save' " TODO
" Plug 'milkypostman/vim-togglelist' " TODO
" Plug 'lyokha/vim-xkbswitch' " TODO
" Plug 'ludovicchabant/vim-gutentags' " TODO
" Plug 'Majutsushi/tagbar' " TODO
" {{{
"   nmap <F8> :TagbarToggle<CR>
" }}}
" Plug 'mhinz/vim-startify' " TODO
" Plug 'reedes/vim-litecorrect' " TODO

call plug#end()

""" {{{1 Options
" ====================================================================

" TODO Check timeout
" set ttimeout
" set ttimeoutlen=0

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set background=dark
colorscheme base16-railscasts

set pastetoggle=<F5>
set clipboard=unnamed,unnamedplus

let g:mapleader = "\<space>"

set tabstop=4
set shiftwidth=4
set softtabstop=4
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

nnoremap <leader><space> :noh<cr>

vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

set number
nnoremap <F2> :NumbersToggle<CR>
let g:numbers_exclude = ['unite', 'vimfiler', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

noremap <Leader><Leader> <C-^>

" only smart break at the break characters (. , :)
set linebreak

set formatoptions=qrcnlj1

inoremap jj <ESC>

augroup python
    au FileType python setlocal textwidth=80
    au FileType python setlocal colorcolumn=80
augroup END

autocmd Filetype html,html.handlebars,jst,javascript,json setlocal ts=2 sw=2 expandtab

" vim: set sw=2 ts=2 et foldlevel=1 foldmethod=marker:
