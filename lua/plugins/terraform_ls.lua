
return {
    "hashicorp/terraform-ls",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
    config = function() 
        vim.lsp.config("terraformls",{})
        vim.api.nvim_create_autocmd({"BufWritePre"}, {
            pattern = {"*.tf", "*.tfvars"},
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
}
