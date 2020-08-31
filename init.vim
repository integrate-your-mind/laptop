" Plugins
call plug#begin()
" nvim v0.4.3
Plug 'mjbrownie/browser.vim'
Plug 'vim-scripts/asmM6502.vim'
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
Plug 'paulkass/jira-vim', { 'do': 'pip install -r requirements.txt' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'chr4/nginx.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

" Needed for vim tags
set backspace=indent,eol,start

" length of an actual \t character:
set tabstop=2

" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=-1

" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0

" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
set expandtab

" reproduce the indentation of the previous line:
set autoindent

" keep indentation produced by 'autoindent' if leaving the line blank:
set cpoptions+=I

" try to be smart (increase the indenting level after ‘{’,
" decrease it after ‘}’, and so on):
set smartindent

" a stricter alternative which works better for the C language:
" set cindent

" use language‐specific plugins for indenting (better):
filetype plugin indent on

" force vim to reload the buffer
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Cool hover action
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

"" Silver Searcher for Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Set encoding to UTF-8
set encoding=UTF-8

" Set terminal true colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Set line numbers
set nonumber

" Load colors if they aren't already loaded
if (has("termguicolors"))
 set termguicolors
endif
autocmd vimenter * colorscheme gruvbox

" Enable Syntax
syntax enable

" Set italics
let g:gruvbox_italic=1

"Set Colorscheme
colorscheme gruvbox
let g:airline_theme='gruvbox'

" Styles
" Power line style
let g:airline_powerline_fonts = 1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | Startify| endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify| endif

" Custom Config
" Coc
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" Fuzzy Search
set rtp+=/usr/local/opt/fzf
" nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"Nerd Tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <silent> <C-m> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" If nerd tree is the only window close it, the buffer might stay open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Setup panel switching
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" TODO: Fix Me
" For tmux integration with vim split terms
" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" Vim Commentary Config
autocmd FileType apache setlocal commentstring=#\ %s

" ZenRoom 2 Config
nnoremap <silent> <leader>z :Goyo<cr>

" CoC Config
" Setting up tab completion for CoC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" TextEdit might fail if hidden is not set.
set hidden

" Needed for html tags to complete properly


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>

" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+
"END CoC Config
"
"" Vim Tmux Navigator Config
let g:tmux_navigator_save_on_switch = 2

" Lazygit config
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9"

"VimJira config 
   let g:jiraVimDomainName = "http://knoxfinancial.atlassian.net"
      let g:jiraVimEmail = "roman@knoxfinancial.com"
      let g:jiraVimToken = "1e73tJSVVQwZ6dZ7j3f6D15A"
      " setup mapping to call :LazyGit
nnoremap <silent> <leader>lg :LazyGit<CR>

inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O
