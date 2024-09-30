" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
" set nocompatible

" Install plugins with vim-plug https://github.com/junegunn/vim-plug
" Reload and runs :PlugInstall to install plugins

set number
set shiftwidth=2
set tabstop=2
set noshowmode
set noruler
set noshowcmd
set laststatus=0

call plug#begin()

	Plug 'Mofiqul/vscode.nvim'
	Plug 'github/copilot.vim'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'omnisyle/nvim-hidesig'
	Plug 'kassio/neoterm'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'rhysd/devdocs.vim'
	Plug 'rmagatti/goto-preview'
	Plug 'tpope/vim-bundler'
	Plug 'tpope/vim-endwise'
	Plug 'tpope/vim-rails'
	Plug 'tpope/vim-surround'
	Plug 'vim-ruby/vim-ruby'
	Plug 'vim-test/vim-test'
	Plug 'windwp/nvim-autopairs'
	Plug 'wsdjeg/vim-fetch'

call plug#end()

colorscheme vscode

" disable netrw at the very start of your init.vim
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" optionally enable 24-bit colour
set termguicolors

lua << EOF
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				none = " ",
			}
		},
  },
  filters = {
    dotfiles = true,
		custom = { "^.git$" }
  },
	hijack_cursor = true,
  open_on_tab = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})

EOF

lua << EOF
local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup {
	indent = {
		highlight = highlight,
		char = "│"
	},
	whitespace = {
		remove_blankline_trail = false
	}
}
EOF

nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>e :History<CR>

set cursorline

set formatoptions-=t

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula', -- Or any other theme you prefer
    component_separators = '|',
    section_separators = '',
  },
  sections = {
		lualine_a = {{'filename', path = 1}},
    lualine_b = {'location'},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
    lualine_z = {'branch'}
  }
}
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "ruby", "javascript", "typescript", "tsx" },
	highlight = {
    enable = true,              -- Enable highlighting
    additional_vim_regex_highlighting = false, -- Disable old syntax highlighting
  },
}
-- Folding settings
vim.o.foldmethod = "syntax" -- or "manual", "indent", "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = '1'
vim.o.foldtext = 'getline(v:foldstart)'

-- Key mappings for folding
vim.api.nvim_set_keymap('n', '<Leader>z', 'za', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>c', 'zc', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>o', 'zo', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>C', 'zM', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>O', 'zR', { noremap = true, silent = true })
EOF

" gitsigns setup
lua << EOF
require('gitsigns').setup({
  current_line_blame = true,
	current_line_blame_opts = {
		delay = 0,
	},
})
EOF
