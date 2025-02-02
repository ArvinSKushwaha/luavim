--[[-------------------------------------]] --
--      keymaps - general mappings        --
--              Author: elai               --
--             License: GPLv3              --
--[[-------------------------------------]] --

-- Shorten function name
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
map("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal Mode --
-----------------
-- Mappings for moving through splits
map("n", "<A-h>", "<C-w>h", {})
map("n", "<A-j>", "<C-w>j", {})
map("n", "<A-k>", "<C-w>k", {})
map("n", "<A-l>", "<C-w>l", {})

-- Resize current buffer by +/- 2
map("n", "<C-w><C-h>", ":vertical resize +2<cr>", {})
map("n", "<C-w><C-j>", ":resize +2<cr>", {})
map("n", "<C-w><C-k>", ":resize -2<cr>", {})
map("n", "<C-w><C-l>", ":vertical resize -2<cr>", {})

-- Alternate way to save and quit nvim
map("n", "<A-w>", ":w<CR>", {}) -- save file
map("n", "<A-q>", ":q<CR>", {}) -- quit nvim
map("n", "<A-1>", ":q!<CR>", {}) -- quit without saving

-- Nvim Comment
map("n", "<C-l>", ":CommentToggle<CR>", {}) -- Comment One Line
map("x", "<C-l>", ":'<,'>CommentToggle<CR>", {}) -- Comment Multiple Lines In Visual Mode
map("n", "<C-l><C-p>", "vip:CommentToggle<CR>", {}) -- Comment A Paragraph

-- Don't accidently create macros when trying to quit
-- map('n', 'Q', 'q', {})
-- map('n', 'q', '<nop>', {})

-- Delete without copying to buffer
map('n', "<leader>d", "\"_d", {})
map('x', "<leader>d", "\"_d", {})

-- Crates Config
map('n', "<leader>cv", ":lua require('crates').show_versions_popup()<cr>", {})
map('n', "<leader>cf", ":lua require('crates').show_features_popup()<cr>", {})
map('n', "<leader>cD", ":lua require('crates').open_documentation()<cr>", {})

-- GitSings mappings
-- map ('n', "<leader>h", ":Gitsigns preview_hunk<CR>", {})  -- preview_hunk
-- map ('n', "<leader>r", ":Gitsigns reset_buffer<CR>", {})  -- reset_buffer

-- Toggle Alpha Dashboard
map('n', "<leader>a", ":set laststatus=3<CR> | :Alpha<CR>", {})

-- Toggle NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", {})

-- Yank entire line
map("n", "yie", ":<C-u>%y<CR>", {})

-- Packer Update
map("n", "<leader>u", ":PackerSync<CR>", {})

-- Toggle Terminal
map("n", "<leader>t", ":ToggleTerm<CR>", {})

-- Telescope
map("n", "<leader>T", ":Telescope<CR>", {})
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", {})
map("n", "<leader>fS", "<cmd>Telescope lsp_document_symbols<cr>", {})


-- Markdown Preview
map("n", "<leader>m", ":MarkdownPreviewToggle<cr>", {})

-- Tagbar
map("n", "<leader>o", ":TagbarToggle<cr>", {})

-----------------
-- Insert Mode --
-----------------
-- Map Escape Key To kj
map("i", "kj", "<ESC>", {})

-- Fix One [Car] behind
map("i", "<Esc>", "<Esc>`^", {})

-- Center screen after search
vim.cmd([[
nnoremap n nzzzv
nnoremap N Nzzzv
]])

-- Move End of Line
map("i", "<C-e>", "<End>", {})
-- Move Beginning of Line
map("i", "<C-a>", "<Home>", {})

-----------------
-- Visual Mode --
-----------------
-- Move Text Up And Down
vim.cmd([[
nnoremap <C-A-J> :m .+1<CR>==
nnoremap <C-A-K> :m .-2<CR>==
inoremap <C-A-J> <Esc>:m .+1<CR>==gi
inoremap <C-A-K> <Esc>:m .-2<CR>==gi
vnoremap <C-A-J> :m '>+1<CR>gv=gv
vnoremap <C-A-K> :m '<-2<CR>gv=gv
]])

--------------------------------------
-- keymaps that i don't use anymore --
--------------------------------------
-- -- Auto Pairs
-- vim.cmd([[
-- inoremap ( ()<left>
-- inoremap [ []<left>
-- inoremap { {}<left>
-- inoremap {<CR> {<CR>}<ESC>0
-- inoremap {;<CR> {<CR>};<ESC>0
-- nnoremap <Leader>o o<Esc>^Da
-- nnoremap <Leader>O O<Esc>^Da
-- inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
-- inoremap " ""<left>
-- inoremap ' ''<left>
-- ]])

-- -- Better tabbing
-- map ("n", "<", "<gv", {})
-- map ("n", ">", ">gv", {})

-- -- Mappings for scrolling up And down
-- map ("n", "<A-k>", "<C-u>k", {})
-- map ("n", "<A-j>", "<C-d>j", {})

-- -- TAB SHIFT-TAB will go back
-- map ("n", "<TAB>", ":bnext<CR>", {})
-- map ("n", "<S-TAB>", ":bprevious<CR>", {})

-- -- Terminal
-- map ("n", "<leader>t", ":vnew term://zsh<CR>", {})

-- -- Improve scroll
-- vim.cmd([[noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
-- noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
-- noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
-- noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")
-- ]])

-- -- Mappings For Tabs
-- map ("n", "o<Leader>1", "<Plug>lightline#bufferline#go(1)", {})
-- map ("n", "o<Leader>2", "<Plug>lightline#bufferline#go(2)", {})
-- map ("n", "o<Leader>3", "<Plug>lightline#bufferline#go(3)", {})
-- map ("n", "o<Leader>4", "<Plug>lightline#bufferline#go(4)", {})
-- map ("n", "o<Leader>5", "<Plug>lightline#bufferline#go(5)", {})
-- map ("n", "o<Leader>6", "<Plug>lightline#bufferline#go(6)", {})
-- map ("n", "o<Leader>7", "<Plug>lightline#bufferline#go(7)", {})
-- map ("n", "o<Leader>8", "<Plug>lightline#bufferline#go(8)", {})
-- map ("n", "o<Leader>9", "<Plug>lightline#bufferline#go(9)", {})
-- map ("n", "o<Leader>0", "<Plug>lightline#bufferline#go(10)", {})

map("n", "h", "gh", {})
map("n", "h", "gj", {})
map("n", "h", "gk", {})
map("n", "h", "gl", {})

map("s", "h", "gh", {})
map("s", "j", "gj", {})
map("s", "k", "gk", {})
map("s", "l", "gl", {})

map("v", "h", "gh", {})
map("v", "j", "gj", {})
map("v", "k", "gk", {})
map("v", "l", "gl", {})

