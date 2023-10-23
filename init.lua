require "keymaps"
require "toggleterm-config"
require "nvim-tree-config"
require "options"
require "lazy-config"
require "alpha-config"
require "lualine-config"
require "treesitter-config"
require "telescope-config"
require "whichkey"
require "bufferline-config"
vim.cmd "colorscheme neg"

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    },
})
