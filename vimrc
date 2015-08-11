" vim:fdm=marker
" TODO: switch back lower-range markers to the "{{{  }}}" format

"""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""" VIM CONFIG """"""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""

" {{{1 Basic vimrc headers
set nocompatible

" {{{1 Plugins
" {{{2 Installing vim-plug if not yet installed
if empty(glob('~/.vim/autoload/plug.vim'))
  !mkdir -p ~/.vim/autoload
  !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" {{{2 loading Vim-Plug
call plug#begin('~/.vim/bundle')
" {{{2 Project manager
" {{{3 workspace manager!
Plug 'szw/vim-ctrlspace'
" {{{3 Move to the root directory of a project
Plug 'airblade/vim-rooter'
" {{{3 Handle projects in vim
Plug 'RomainEndelin/vim-projectionist'
" Plug 'tpope/vim-projectionist'
" {{{3 Add unite interface to *vim-projectionist*
Plug 'RomainEndelin/fusion.vim'
" {{{3 Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'tacahiroy/ctrlp-funky'
" {{{2 Technical
" {{{3 Unite!
Plug 'Shougo/unite.vim'
" {{{3 Another Shougo's genius: asynchronous
Plug 'Shougo/vimproc.vim', { 'do' : 'make -f make_unix.mak' }
" {{{3 enable custom repetitions
Plug 'tpope/vim-repeat'
" {{{3 Interactive tutorials
Plug 'fmoralesc/vim-tutor-mode'
" {{{2 User Interface
" {{{3 fancy bar at the bottom
Plug 'bling/vim-airline'
" {{{ Dynamically adapt the tmux plugin
Plug 'edkolev/tmuxline.vim'
" {{{3 maximize/restore window
Plug 'szw/vim-maximizer'
" {{{3 Semantic highlighting
Plug 'jaxbot/semantic-highlight.vim'
" {{{3 switch between relative and absolute line numbering
Plug 'myusuf3/numbers.vim'
" {{{3 beautiful parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" {{{3 Nice file explorer
Plug 'Shougo/vimfiler.vim', {'on': 'VimFiler'}
" {{{3 distraction free mode
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
" {{{3 Easily display vim windows
Plug 't9md/vim-choosewin'
" {{{3 Toggle vim quickfix/location
Plug 'milkypostman/vim-togglelist'
" {{{3 Get a list of unicode glyphes
Plug 'sanford1/unite-unicode'
" {{{3 Visualize the undo tree
Plug 'sjl/gundo.vim'
" {{{2 Color schemes
" {{{3 solarized theme
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
" {{{3 Colorscheme selection
Plug 'ujihisa/unite-colorscheme'

" {{{2 Syntax enhancement
" {{{3 easily comment files
Plug 'tomtom/tcomment_vim'
" {{{3 Speeddating
Plug 'tpope/vim-speeddating'
" {{{3 quoting surround facilities
Plug 'tpope/vim-surround'
" {{{3 helpers for UNIX
Plug 'tpope/vim-eunuch'
" {{{3 Ack integration
Plug 'mileszs/ack.vim', {'on': 'Ack'}
" {{{3 Search for TODOS in code
Plug 'gilsondev/searchtasks.vim' ", {'on': 'SearchTasks'}
" {{{3 easily align text
" Plug 'godlygeek/tabular', {'on': ['Tabular', 'Tabularize']}
Plug 'junegunn/vim-easy-align'
" {{{3 useful defaults
" TODO: Read each of these config and set it up manually
Plug 'tpope/vim-sensible'
" {{{3 smart quote pairing
Plug 'Raimondi/delimitMate'
" {{{3 syntax checking
Plug 'scrooloose/syntastic'
" {{{3 tags browsing
Plug 'Majutsushi/tagbar'
" {{{3 Multiple cursors in vim
" TODO: Learn it
Plug 'kristijanhusak/vim-multiple-cursors'
" {{{3 Insert dummy text on need
Plug 'loremipsum', {'on': 'Loremipsum'}

" {{{2 Completion
" {{{3 Easy tab completion
Plug 'ervandew/supertab'
" {{{3 Completion engine
" Plug 'Shougo/neocomplete.vim'
Plug 'Valloric/YouCompleteMe', {'do': './install.sh'}
" {{{3 snippets manager
Plug 'SirVer/ultisnips'
Plug 'Shougo/neosnippet.vim'
" {{{3 Collection of snippets
Plug 'honza/vim-snippets'

" {{{2 Git
" {{{3 git integration
Plug 'tpope/vim-fugitive'
" {{{3 display git changes
" Plug 'airblade/vim-gitgutter'

" {{{2 Tmux integration
" {{{3 asynchronous executions on tmux
Plug 'tpope/vim-dispatch', {'on': ['Make', 'Dispatch']}
" {{{3 seamless navigation with tmux
Plug 'christoomey/vim-tmux-navigator'

" {{{2 Pair programming
Plug 'FredKSchott/CoVim', { 'on': 'CoVim', 'do': 'pip install --user twisted argparse'}
" {{{2 Tool Specific
" {{{3 Python
" {{{4 python mode
Plug 'klen/python-mode', {'for': 'python'}
" {{{4 binding with ipython
Plug 'ivanov/vim-ipython', {'for': 'python'}
" {{{4 Completion
" Plug 'davidhalter/jedi-vim', {'for': 'python'}
" {{{3 R
" {{{4 R integration
Plug 'Vim-R-plugin', {'for': 'r'}
" {{{3 Ruby
" {{{4 Rails.vim
Plug 'tpope/vim-rails'
" {{{3 Semantic Web
" {{{4 semantic Web facilities
Plug 'seebi/semweb.vim', {'for': ['sparql', 'n3']}
"
" {{{3 Web
" {{{4 HTML5 integration
Plug 'othree/html5.vim', {'for': ['html', 'html.handlebars', 'html.mustache']}
" {{{4 HTML5 shortcuts
Plug 'mattn/emmet-vim', {'for': ['html', 'html.handlebars', 'html.mustache']}
" {{{4 javascript integration
Plug 'jelera/vim-javascript-syntax', {'for': 'jst'}
" {{{4 EJS syntax and snippets
Plug 'evidens/vim-jst', {'for': 'jst'}
" {{{4 Handlebars & mustaches
Plug 'mustache/vim-mustache-handlebars', {'for': ['html.handlebars', 'html.mustache']}
" {{{4 javascript autocompletion
Plug 'marijnh/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}
" {{{4 node omnicompletion
" Plug 'ahayman/vim-nodejs-complete'
" {{{4 Javascript syntax for libraries
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
" {{{4 Smart Javascript indent
Plug 'nemtsov/JavaScript-Indent', {'for': 'javscript'}
" {{{4 NodeJS
Plug 'moll/vim-node', {'for': 'javascript'}

" {{{3 JSON
" {{{4 json highlighting
Plug 'elzr/vim-json', {'for': 'json'}
"
" {{{3 Latex
" {{{4 LaTeX integration
Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': ['tex', 'bib']}
" Plug 'RomainEndelin/LaTeX-Box', {'for': ['tex', 'bib']}

" {{{3 Ansible
Plug 'chase/vim-ansible-yaml'
" {{{2 Text
" {{{3 Markdown
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'fmoralesc/vim-pad'
Plug 'plasticboy/vim-markdown'


" {{{3 univeral text linking
Plug 'utl.vim'

" {{{ Light correction
Plug 'reedes/vim-litecorrect'
" {{{3 Outliner
Plug 'vimoutliner/vimoutliner', {'for': 'votl'}
" {{{2 Productivity
" {{{3 Vim-Taskwarrior
Plug 'farseer90718/vim-taskwarrior'
" {{{3 Deprecated
" {{{4 Narrow Region
" Plug 'chrisbra/NrrwRgn'
" {{{4 adds a calendar window to vim
" Plug 'mattn/calendar-vim'

" {{{2 leaving vim-plug
call plug#end()

" {{{1 General options
" {{{2 Colorscheme
set t_Co=256
let base16colorspace=256

set background=dark
colorscheme base16-railscasts

" {{{2 Swap/backup files
" Basically, we disable backups
set noswapfile
set dir=/tmp
set nowb
set nobackup

" {{{2 Update time
set updatetime=200

" {{{2 Better copy and paste
set pastetoggle=<F5>
set clipboard=unnamed

" {{{2 Display incomplete commands
set showcmd

" {{{2 Tabs are made of 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" {{{2 Fold by syntax
set foldmethod=syntax

" {{{2 Disabling ex mode
nmap Q <Nop>
" {{{2 More natural split
set splitright
set splitbelow

" {{{2 Display UTF-8 characters
set encoding=utf-8

" {{{2 Minimum number of line to keep above/under the cursor
set scrolloff=5

" {{{2 Smart indent in insert mode
" Indent new line by default
" If we leave the newline blank while switching to normal mode, remove the
" indent
set autoindent

" {{{2 Handy menu completion
set wildmenu
set wildmode=list:longest,full

" {{{2 Get rid of binary files in completion
set wildignore+=*.swp
set wildignore+=*.jpg,*.bmp,*.gif
set wildignore+=*.pdf
set wildignore+=*.pyc
set wildignore+=*.o,*.obj,*.dll,*.exe
set wildignore+=*.aux,*.out,*.toc

" {{{2 Show line and column number
set ruler

" {{{2 Smoother use of backspace command
set backspace=indent,eol,start

" {{{2 Smarter case handling in searches
" Ignore case, unless we use capslock
set ignorecase
set smartcase

" {{{2 Highlight search results as we type
set incsearch
set showmatch
set hlsearch

" {{{2 Hide result highlighting with \<space>
nnoremap <leader><space> :noh<cr>

" {{{2 Close quickfix and preview with \c
nnoremap <leader>cc :pclose<cr>

" {{{2 Easy navigating between errors
nnoremap ]] :lne<cr>
nnoremap [[ :lp<cr>
" {{{2 TODO: Correctly handle long lines
" set wrap
" set textwidth=79
" set formatoptions=qrn1
" set colorcolumn=85

" {{{2 Move on actual vim lines rather than the file lines
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" {{{2 Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" {{{2 Select all in current buffer
nnoremap <Leader>a ggVG

" {{{2 Switch between relative an absolute line numbering with F2
set number
nnoremap <F2> :NumbersToggle<CR>
let g:numbers_exclude = ['unite', 'vimfiler', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']
" {{{2 Fast tab access
nnoremap gr   :tabprevious<CR>
" nnoremap gt   :tabnext<CR>

nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt
nnoremap g6 6gt
nnoremap g7 7gt
nnoremap g8 8gt
nnoremap g9 9gt
nnoremap g0 10gt

" {{{2 Alternate buffer
noremap <Leader><Leader> <C-^>

" {{{2 Wrap lines visually, but no hard wrap
set wrap

" only smart break at the break characters (. , :)
set linebreak
set nolist

" {{{2 Formating options
" q: allow formatting of comments
" r: carry the current comment forward on next line
" n: smart indent on lists (when wrapping in an item)
" l: no automatic linebreak
set formatoptions=qrn1

" {{{2 Faster escape from insert mode
" We assume we never write jj
inoremap jj <ESC>

" {{{2 Handling mouse
set mouse=a
" {{{2 Easy insert Date
nnoremap <leader>d "=strftime('%FT%T%z')<c-m>P
nnoremap <leader><s-d> 24x"=strftime('%FT%T%z')<c-m>P

" {{{1 Language specific
" {{{2 Latex
au filetype tex command! Romain :normal i\romain{}<ESC>
au filetype tex nnoremap <buffer> Q :Romain<cr>i

" {{{2 Python
au FileType python setlocal textwidth=80
au FileType python setlocal colorcolumn=80

au FileType python setlocal completeopt-=preview

" {{{2 N3
autocmd FileType n3 set commentstring=#\ %s

" {{{2 HTML
autocmd Filetype html,html.handlebars,jst setlocal ts=2 sw=2 expandtab

" {{{2 JS
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
au FileType javascript setlocal textwidth=80
au FileType javascript setlocal colorcolumn=80

" {{{2 Json
autocmd Filetype json setlocal ts=2 sw=2 expandtab

" {{{2 Todo
function! SetDos()
    e ++ff=dos
    syntax on
endfunction
autocmd Filetype todo call SetDos()
" {{{1 Plugins configuration
" {{{2 Rainbow parentheses
" autocmd VimEnter * RainbowParentheses
" autocmd FileType pandoc RainbowParentheses!
" autocmd FileType todo RainbowParentheses!

" {{{2 Ctrlspace
" Hide the buffer list
set hidden
let g:CtrlSpaceDefaultMappingKey = ","

let g:CtrlSpaceFileEngine = "file_engine_linux_amd64"
" let g:ctrlspace_use_mouse_and_arrows = 1

" {{{2 Python-mode
" TODO: check this config

let g:pymode_run = 0
let g:pymode_warnings = 0
let g:pymode_rope = 0
let g:pymode_lint_write = 0
" let g:pymode_run_key = '<leader>r'
" let g:pymode_syntax_slow_sync = 1
" let g:pymode_lint_checker = "pylint
let g:pymode_lint_ignore = "C0103"
let g:pymode_lint_cwindow = 0
" map <leader>j :RopeGotoDefinition<CR>
" map <leader>r :RopeRename<CR>

" {{{2 Goyo
nnoremap <Leader>f :Goyo<CR>
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
    NumbersEnable
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

let g:limelight_conceal_ctermfg = 'gray'

" {{{2 Vim dispatch
" TODO: Does this go to *language specific* ?
autocmd FileType python let b:dispatch = 'python %'
nnoremap <leader>rr :Dispatch<CR>
nnoremap <leader>ri :Dispatch ipython -i %<CR>
" {{{2 Tagbar
nmap <F8> :TagbarToggle<CR>

" {{{2 Syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_cursor_column = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "!!"
let g:syntastic_style_error_symbol = "S!"
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 7

let g:syntastic_javascript_checkers = ['eslint']

nnoremap <leader>e :Errors<cr>

" {{{2 Vim-R
"let g:vimrplugin_assign = 0
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'g:globalVars',
        \ 'v:functionVariables',
    \ ]
\ }

" {{{2 Vim filer
let g:vimfiler_as_default_explorer = 1

autocmd FileType vimfiler nunmap <buffer> <C-l>
autocmd FileType vimfiler nunmap <buffer> <C-j>

nnoremap <F10> :VimFiler -explorer -buffer-name=explorer -toggle -direction=topleft<cr>

" {{{2 Delimitmate
let delimitMate_nesting_quotes = ['"', '`']
" let delimitMate_excluded_regions = "Comment,String"
let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" {{{2 GitGutter
" let g:gitgutter_sign_column_always = 1

" {{{2 Multiple cursors
" Disable autocomplete before multiple cursors to avoid conflict
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
endfunction

" Enable autocomplete after multiple cursors
function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
endfunction

" {{{2 Vim-airline
let g:airline_powerline_fonts = 1
set laststatus=2
" for compatibility with ctrlspace
let g:airline_exclude_preview = 1
" Disabling vim powerline
let g:powerline_loaded = 1

let g:tmuxline_preset = 'full'

" {{{2 Vim-ChooseWin
let g:choosewin_overlay_enable = 1

" {{{2 Vim-json
" disable double-quote hiding
let g:vim_json_syntax_conceal = 0

" {{{2 Vim markdown
" let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1

au FileType mkd,markdown nnoremap <buffer> <localleader>l :Toc<CR>

" {{{2 Vim-Pencil

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init() |
                              \ setl spell spl=en_us,fr fdl=4 |
                              \ setl fdo+=search
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT* |
                              \ setl spell spl=en_us,fr |
                              \ call litecorrect#init() |
                              \ setl spell spl=en_us et noai
  autocmd Filetype mail         call litecorrect#init() |
                              \ setl spell spl=en_us,fr noai
augroup END

" {{{2 Javascript syntax
let g:used_javascript_libs = 'underscore,jquery'

" {{{2 Emmet
let g:use_emmet_complete_tag = 1

" {{{2 tComment

autocmd VimEnter * map gcc <c-_><c-_>

" {{{2 semantic-highlighting

nnoremap <Leader>ss :SemanticHighlightToggle<cr>
let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]

" {{{2 Gundo
nnoremap <F6> :GundoToggle<CR>

" {{{2 Searchtasks

let g:searchtasks_list=["TODO", "FIXME", "XXX"]

" {{{2 Vim projectionist
let g:projectionist_heuristics = {
            \   "config/controllers.js": {
            \     "api/controllers/*Controller.js": {"type": "controller"},
            \     "api/models/*.js": {"type": "model"},
            \     "api/views/**/*.js": {"type": "view"},
            \     "api/policies/*.js": {"type": "policy"},
            \     "api/adapters/*.js": {"type": "adapter"},
            \     "api/services/*.js": {"type": "service"},
            \     "config/*.js": {"type": "config"}
            \   },
            \   "app/app.js": {
            \     "app/controllers/*.js": {"type": "controller"},
            \     "app/models/*.js": {"type": "model"},
            \     "app/routes/*.js": {"type": "route"},
            \     "app/router.js": {"type": "route"},
            \     "app/styles/*.js": {"type": "style"},
            \     "app/styles/app.js": {"type": "style"},
            \     "app/templates/*.hbs": {"type": "template"},
            \     "app/templates/application.hbs": {"type": "template"},
            \     "app/views/*.js": {"type": "view"},
            \     "app/helpers/*.js": {"type": "helpers"},
            \     "app/components/*.js": {"type": "component"},
            \     "app/adapters/*.js": {"type": "adapter"},
            \     "app/app.js": {"type": "config"},
            \     "config/*.js": {"type": "config"},
            \     "bower.json": {"type": "config"},
            \     "package.json": {"type": "config"},
            \     "Brocfile.js": {"type": "config"},
            \   }
            \ }

" {{{2 Vim fusion
let g:fusion_files_start_insert = 0
nnoremap <C-f> :Unite projection-categories<cr>

" {{{2 VimOutliner
au FileType votl setlocal ts=2 sts=2 sw=2

" {{{2 Vim pandoc
let g:pandoc#hypertext#create_if_no_alternates_exists = 1
let g:pandoc#hypertext#open_cmd = 'edit'

" " {{{2 Vim pad
" let g:pad#default_format = "pandoc"
"
" let g:pad#dir = "~/braindump/notes"
" let g:pad#local_dir = "notes"

" {{{2 Latex-box

" let g:LatexBox_latexmk_async=1
let g:LatexBox_split_width=60

function! LatexEvinceSearch()
    execute '!evince_dbus "' . LatexBox_GetOutputFile(). '" ' . line('.') . ' "%:p"'
endfun
command! LatexEvinceSearch call LatexEvinceSearch()
au FileType tex nnoremap <leader>ls :silent LatexEvinceSearch<cr>:redraw!<cr>

let g:LatexBox_ignore_warnings = ['Underfull', 'Overfull', 'specifier changed to', 'Empty']

let g:LatexBox_quickfix = 2

let g:LatexBox_Folding = 1

" {{{2 Alignment
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" {{{2 Completion
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" {{{2 CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'

if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
endif
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command =
                \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
else
    " Fall back to using git ls-files if Ag is not available
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

nnoremap <C-o> :CtrlPBuffer<cr>

nnoremap <leader>y :CtrlPYankring<cr>
nnoremap <C-]> :CtrlPFunky<cr>

" {{{2 CoVim
let CoVim_default_name = "kilik"
let CoVim_default_name = "7877"
" {{{2 Unite.vim
let g:unite_source_history_yank_enable = 1
call unite#custom#profile('default', 'context', {
            \ 'winheight': 10,
            \ 'direction': 'botright',
            \ 'prompt': '» ',
            \ })

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" {{{2 Unite plugins
nnoremap <Leader><S-c> :Unite colorscheme<CR>

" {{{1 File specific

autocmd BufRead ~/1_current/thesis/outline/thesis_outline.otl nnoremap <buffer> <leader>ll :!thesis_otl2pdf % master.tex<cr><cr>
autocmd BufRead,BufNewFile ~/1_current/thesis/{**/,}*.tex let g:LatexBox_jobname='thesis'
autocmd BufRead,BufNewFile ~/1_current/thesis/{**/,}*.tex let g:LatexBox_build_dir='build'
autocmd BufRead,BufNewFile ~/1_current/thesis/{**/,}*.tex abbreviate ddd \todo{
