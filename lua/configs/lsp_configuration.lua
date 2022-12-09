local lsp_status = require('lsp-status')

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
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

lsp_status.config({
    indicator_errors = ' ',
    indicator_warnings = ' ',
    indicator_info = ' ',
    indicator_hint = ' ',
    indicator_ok = ' ',
    show_filename = false,
    current_function = true,
})

lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    lsp_status.on_attach(client)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- local bufopts = { noremap = true, silent = false, buffer = bufnr }
end

require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}

require("mason-lspconfig").setup {
    ensure_installed = {
        'pyright',
        'tsserver',
        'rust_analyzer',
        'sumneko_lua',
        'clangd',
        'cmake',
        'marksman',
        'taplo',
        'html',
        'yamlls',
        'emmet_ls',
        'texlab',
    }
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
    ['yamlls'] = {},
    ['emmet_ls'] = {},
    ['texlab'] = {},
}


local lspconfig = require('lspconfig')

lsps.rust_analyzer = {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy",
            },
            inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisonHints = { enable = "always" },
            },
            -- rust-analyzer.cargo.unsetTest
            cargo = {
                unsetTest = { 'tokio', 'tokio-macros' }
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

require('crates').setup({})

-- vim.lsp.set_log_level("debug")
