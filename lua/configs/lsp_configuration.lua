-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)


local bufopts = opts
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

local lsp_installer = require("nvim-lsp-installer")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- local bufopts = { noremap = true, silent = false, buffer = bufnr }
end

lsp_installer.setup {
    automatic_installation = true
}

local lsps = {
    ['pyright'] = {},
    ['tsserver'] = {},
    ['rust_analyzer'] = {},
    ['sumneko_lua'] = {},
    ['clangd'] = {},
    ['cmake'] = {},
    ['marksman'] = {},
    ['taplo'] = {},
    ['html'] = {},
    ['jdtls'] = {},
}


local lspconfig = require('lspconfig')
-- local coq = require('coq')

lsps.jdtls = {
    settings = {
        java = {
            signatureHelp = {
                enabled = true
            }
        }
    }
}

lsps.rust_analyzer = {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy",
            }
        }
    }
}

for name, config in pairs(lsps) do
    config.on_attach = on_attach
    if name == "rust_analyzer" then
        local ok_rt, rust_tools = pcall(require, "rust-tools")
        if ok_rt then
            rust_tools.setup({
                server = config
            })
            goto continue
        end
    end

    lspconfig[name].setup(config)
    ::continue::
end

require('crates').setup({
})

vim.lsp.set_log_level("debug")
