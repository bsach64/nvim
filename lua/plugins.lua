return {
    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    -- Start screen
    {
        "goolord/alpha-nvim",
        lazy = true,
    },
    --bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    --colorscheme
    {
        'neg-serg/neg.nvim',
    },
    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },

    -- Nvimtree
    {
        'nvim-tree/nvim-tree.lua',
        version = "*",
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    -- whichkey
    {
        "folke/which-key.nvim",
        lazy = true,
    },

    --Telescope
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },

    -- Treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
    },

    -- Language Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'}
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
        {'L3MON4D3/LuaSnip'}
        },
    },

    {
        'akinsho/toggleterm.nvim',
        tag = "*",
        config = true
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

}
