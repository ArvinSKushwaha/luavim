require('telescope').setup({
    pickers = {
        lsp_document_symbols = {
            theme = "cursor",
        }
    }
})
require('telescope').load_extension('fzy_native')
