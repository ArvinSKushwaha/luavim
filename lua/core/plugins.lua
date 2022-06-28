--[[--------------------------------------]] --
--     plugins + packer - configuration     --
--     Author: elai, ChristianChiarulli     --
--             License: GPLv3               --
--[[--------------------------------------]] --

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)

    -- My plugins
    use 'folke/tokyonight.nvim' -- Provides the tokyonight theme.
    use({
        "catppuccin/nvim",
        as = "catppuccin"
    })
    use 'neovim/nvim-lspconfig' -- Configures NeoVim LSP
    use 'williamboman/nvim-lsp-installer' -- Installer for LSPs
    use 'nvim-telescope/telescope.nvim' -- Telescope for Nvim
    use 'nvim-lua/plenary.nvim' -- plenary, a dependency of telescope
    use 'andweeb/presence.nvim' -- Discord RPC manager
    use 'simrat39/rust-tools.nvim' -- Rust Tools
    use 'mfussenegger/nvim-dap' -- Rust Tools dependency for debugging
    use { -- Crates management for Rust
        'saecki/crates.nvim',
        tag = 'v0.2.1',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Git integration for buffers
    use {
        'lewis6991/gitsigns.nvim',
        event = { "CursorMoved", "CursorMovedI" },
        config = function()
            require("gitsigns")
        end
    }

    use "wbthomason/packer.nvim" -- A use-package inspired plugin manager for Neovim
    use 'shaunsingh/nord.nvim' -- Nord Theme
    use "kyazdani42/nvim-web-devicons" -- Lua fork of vim-web-devicons for neovim
    -- use "kyazdani42/nvim-tree.lua" -- A file explorer tree for neovim written in lua
    use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }
    use "nvim-treesitter/nvim-treesitter" -- Treesitter Syntax highlighting and abstraction layer
    use "nvim-lualine/lualine.nvim" -- Fast and easy statusline for neovim
    use "goolord/alpha-nvim" -- lua powered greeter like vim-startify / dashboard-nvim
    use "akinsho/nvim-toggleterm.lua" -- Plugin to easily toggle a terminal
    use "terrortylor/nvim-comment" -- Comment toggler for Neovim written in Lua
    use "norcalli/nvim-colorizer.lua" -- Colors highlighter for neovim
    use "hrsh7th/nvim-cmp" -- completion plugin for neovim coded in Lua
    use "hrsh7th/cmp-path" -- Nvim-cmp source for path
    use 'hrsh7th/cmp-nvim-lsp' -- Nvim-cmp source for LSP
    -- use 'github/copilot.vim' -- Copilot
    -- use 'hrsh7th/cmp-copilot' -- Nvim-cmo source for Copilot
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "lewis6991/impatient.nvim" -- Speed up loading Lua modules to improve startup time
    use "karb94/neoscroll.nvim" -- Smooth scrolling plugin written in lua

    use { 'romgrk/fzy-lua-native', run = 'make' }
    use { 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }

    use 'hjson/vim-hjson'
    use 'nanozuki/tabby.nvim'

    -- use { 'ms-jpq/coq_nvim', { branch = 'coq' } } -- Completion plugin
    -- use { 'ms-jpq/coq.artifacts', { branch = 'artifacts' } }
    -- use { 'ms-jpq/coq.thirdparty', { branch = '3p' } }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
