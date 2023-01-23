" wsl用
" linux上で使えない項目多数

" leaderをスペースに設定
let mapleader = "\<Space>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.config/nvim/dein/')

execute 'set runtimepath+=' . s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:dein_dir . '/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:dein_dir . '/lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" コマンドでファイルを開く
command! Config :e ~/.config/nvim/init.vim
command! Plugin :e ~/.config/nvim/dein/plugins.toml
command! Lazy :e ~/.config/nvim/dein/lazy.toml
"End dein Scripts-------------------------

" 行数表示
set number
"バックアップファイルを作成しない
set nobackup
" 外部で変更のあったファイルを自動で読み直す
set autoread
" 入力中のコマンドをステータスバーに表示する
set showcmd
" インデント設定
set autoindent
set smartindent
" 表示色設定
set termguicolors
" 履歴
set history=1000
" ベルを視覚表示
set visualbell
" 対応する括弧を表示
set showmatch
set matchtime=1
" 文字を可視化
set list listchars=trail:_
set list listchars=tab:\\t
" 全角文字のサイズを修正
set ambiwidth=double
" 検索系
set hlsearch
set ignorecase
set smartcase
set incsearch
" 先頭まで検索がループする
set wrapscan
" 行末までカーソルが届くようになる
set virtualedit=onemore
" 行列強調表示
"set cursorline
"set cursorcolumn
" わからん 何？
set display=lastline
set laststatus=2
" スクロールが画面端でなくなる
set scrolloff=3
set sidescrolloff=16
" 一応エンコード指定
set encoding=utf8
" 折り返し
set wrap
" 折り返さない
" set nowrap
" タブを使用しない
set expandtab
set tabstop=2
set shiftwidth=2
"ポップアップウィンドウ透過
set pumblend=30

"ライトテーマ
"set background=light

" jjでエスケープ
inoremap jj <Esc>

" 表示行移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k


" ウィンドウ操作関連
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>w <C-w>
nnoremap <leader>> <C-w>>
nnoremap <leader>< <C-w><
nnoremap <leader>+ <C-w>+
nnoremap <leader>- <C-w>-

" Yで行末までヤンク
nnoremap Y y$

" バッファ移動
"nnoremap <C-k> :bprev<CR>
"nnoremap <C-j> :bnext<CR>

" ハイライト消す
nnoremap <leader><ESC> :nohl<CR>

" Ctrl-Cで選択範囲をクリップボードに出力
vnoremap <C-c> :w !clip.exe<CR><ESC>

" Ctrl-Nでバッファ新規作成
nnoremap <C-n> :enew<CR>

" Ctrl-Sで保存
nnoremap <C-s> :w<CR>

" Ctrl-wでバッファを閉じる
nnoremap <C-w> :vs<CR>:bprev<CR><C-w>l:bd<CR>

" Alt+上下で列移動
nnoremap <A-j> ddp
nnoremap <A-k> ddkP

" Alt+左右で単語移動
nnoremap <A-h> dwh<S-p>
nnoremap <A-l> dwp

" Ctrl-zをサスペンドでなくundoに変更
nnoremap <C-z> u
inoremap <C-z> <Esc>ui

" Ctrl-aを全選択に変更
nnoremap <C-a> gg<S-v><S-G>
inoremap <C-a> <ESC>gg<S-v><S-G>

" Ctrl-nで新規作成
nnoremap <C-n> :enew<CR>

" Escでnormal
tnoremap <Esc> <C-\><C-n>

" 画面再描画
nnoremap <F5> <C-l>

" エンコード指定開きなおし
command! Sjis :e ++enc=sjis
command! Utf8 :e ++enc=utf-8

" タブ->空白
command! Notab :%s/\t/  /g

" diff垂直分割
"command! -complete=file_in_path -nargs=1 Diff :vert diffs <args>

"WinMerge
command! -complete=file_in_path -nargs=+ Diff call Diff(<f-args>)
function! Diff(...)
  if a:0 == 1
    call system('WinMergeU.exe '. expand('%') . ' ' . a:1 . '&')
  elseif a:0 == 2
    call system('WinMergeU.exe '. a:1 . ' ' . a:2 . '&')
  endif
endfunction

" C-Bでファイル形式ごとにいろいろやる
nnoremap <C-b> :Build<CR>
command! Build call Build()
function! Build()
  if &filetype == 'python'
    " expand('%')がたまにバグってパスがおかしくなる
    " cmd.exeをコマンドラインで実行してstartで新しいウィンドウ開いてcmd呼び出すと処理後に勝手にウィンドウが閉じない
    " もっといいやりかたを募集中
    call system('cmd.exe /c start cmd /k python ' . expand('%') . ' &')
  endif
endfunction

" プラグインを強制再ダウンロード
"call dein#recache_runtimepath()
