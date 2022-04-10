set tabstop=4 softtabstop=2 shiftwidth=4
filetype plugin indent on
set foldlevelstart=10
set clipboard=unnamed
set signcolumn=number
set encoding=UTF-8
set updatetime=300
set relativenumber
set foldnestmax=40
set tabpagemax=10
set laststatus=2
set foldcolumn=2
set scrolloff=8
set foldenable
set noshowmode 
set expandtab
set linebreak
set wildmenu
set nobackup
set undofile
set mouse=a
set nowrap
set hidden
set number
syntax on
set ruler
set title

call plug#begin('~/.vim/plugged')

" The visual plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'glepnir/dashboard-nvim'
Plug 'norcalli/nvim-colorizer.lua'

" Statusline and buffers tabs
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" Archive Manage
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
let g:dashboard_default_executive = 'telescope'

" Autocomplete experience in Nvim
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Pocco81/AutoSave.nvim'
Plug 'github/copilot.vim'
Plug 'preservim/nerdcommenter'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'j+son', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } 
Plug 'sirver/ultisnips' 
Plug 'honza/vim-snippets'

" Show error hints and highlights
Plug 'vim-syntastic/syntastic'

" SQL Client 
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" Rust Plugin
" Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'saecki/crates.nvim', { 'tag': 'v0.1.0' }

" The power of Git
Plug 'tpope/vim-fugitive'

call plug#end()

" CoC Config

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" NERDTree Config
let NERDTreeHijackNetrw=1

" SQL Client
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_use_nerd_fonts_in_status_line = 1
let g:db_ui_use_nerd_fonts_in_tab_line = 1
let g:db_ui_use_nerd_fonts_in_tab_line_for_tab_name = 1

" Theme Config
set termguicolors
colorscheme tokyonight

" Shortcuts
let mapleader = " "
let g:user_emmet_leader_key= ","

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

" Mappings
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

nnoremap <leader>pc :NERDTreeClose<CR>
nnoremap <leader>pn :NERDTree<CR>

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>ts :tabs<CR>
nnoremap <leader>tc :tabclose<CR>

nnoremap <leader>pp :Prettier<CR>

nnoremap <leader>sq :DBUI<CR> 

" Crates Rust Config

lua require('crates').setup()


" lualine Config

lua << END

  require('lualine').setup {
    options = {
        theme = 'tokyonight',
      }
  }

  require('bufferline').setup()

  require('colorizer').setup {
		 DEFAULT_OPTIONS = {
				RGB      = true;         -- #RGB hex codes
				RRGGBB   = true;         -- #RRGGBB hex codes
				names    = true;         -- "Name" codes like Blue
				RRGGBBAA = true;        -- #RRGGBBAA hex codes
				rgb_fn   = false;        -- CSS rgb() and rgba() functions
				hsl_fn   = false;        -- CSS hsl() and hsla() functions
				css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode     = 'background'; -- Set the display mode.
		}
  }
END


" Autosave
lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_installed = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true, 
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
EOF
 

 
