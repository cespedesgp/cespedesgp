" Desabilitar compatibilidade com vi
set nocompatible

" Definicao das cores do terminal
if has('termguicolors')
  set termguicolors
else
  set t_Co=256
endif

" Habilita deteccao de tipo de arquivo, plugins e indentacao; ativa o realce da sintaxe
filetype plugin indent on
syntax on

" Habilita a barra de titulo; define a string do titulo
"set title
"set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

" Habilita o uso do mouse
"set mouse=a

set encoding=utf-8
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden

" Modifica a ordem padrao de divisao de janelas do vim (abaixo, direita) dependendo do tipo de divisao
set splitbelow
set splitright

" Habilita a busca de arquivos em subdiretorios. Quando apertado TAB no modo comando.
set path=.,**
set wildmenu
set wildmode=longest,full
set wildoptions=pum
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Desabilita o swapfile (nome_do_arquivo.ext.swp); arquivo de backup
set noswapfile
set nobackup

" Configura o diretorio padrao do arquivo desfazer (undo) e habilita a criacao do arquivo undo.
set undodir=~/.vim/undodir
set undofile

" Configura a exebicao do numero da linha (absoluta), e numero de linha relativa (linhas antes e depois da linha do cursor).
set number
set relativenumber

" Configura a quantidade de linhas de 
set scrolloff=10

" Habilita highlight na linha, coluna, respectivamente, onde esta posicionado o cursor.
set cursorline
"set cursorcolumn

" Mudança do cursor por modo
let &t_SI="\e[5 q"
let &t_EI="\e[2 q"

" Configura o comportamento do `modo texto`: Sem quebra de linha, forma como
" sera feita a nova linha, nao exibe caracteres nao imprimiveis, respect.
set nowrap
set linebreak
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲
set fillchars=vert:│,fold:\ ,eob:~,lastline:@
set foldmethod=marker

" Configuracao do comportamento da indentacao
set autoindent
set smartindent

" Configuracao do comportamento da tabulacao
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Configuracao do comportamento das buscas
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

" 
set spelllang=pt_br,en,es
set nospell

set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c

colorscheme desert


" Configuracao dos menus


"set showcmd
"set noshowmode
"set showmatch
"set history=100

" Limpa a barra de status quando o vimrc é recarregado.
set statusline=

" Lado esquerdo da barra de status.
set statusline+=\ %F\ %M\ %Y\ %R

" Utiliza um divisor para separar o lado esquerdo do lado direito.
set statusline+=%=

" Lado direito da barra de status.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Mostra a barra de status na penúltima linha.
set laststatus=2
