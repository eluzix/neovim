-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
        {
            "nvim-treesitter/nvim-treesitter",
            event = "VeryLazy",
            build = ":TSUpdate",
            config = function()
                require("config.treesitter")
            end,
        },

        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp"
        },

        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-cmdline", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
                "saadparwaiz1/cmp_luasnip"
            }
        },

        -- Python indent (follows the PEP8 style)
        { "Vimjas/vim-python-pep8-indent", ft = { "python" } },

        -- Python-related text object
        { "jeetsukumaran/vim-pythonsense", ft = { "python" } },
        
        { "rmehri01/onenord.nvim" },
    -- { "MunifTanjim/nui.nvim", lazy = true },
        -- {
        --   "julienvincent/hunk.nvim",
        --   cmd = { "DiffEditor" },
        --   config = function()
        --      local hunk = require("hunk")
        --     hunk.setup()
        --   end,
        -- },
        {
          'MeanderingProgrammer/render-markdown.nvim',
          dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, 
          opts = {},
          config = function()
            require('render-markdown').setup({
              completions = { lsp = { enabled = true } },
            })
          end,
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
