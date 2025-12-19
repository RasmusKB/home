local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
    vim.notify("mason.nvim is not installed!", vim.log.levels.WARN)
else
    mason.setup({})
end

local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then
    vim.notify("mason-lspconfig.nvim is not installed!", vim.log.levels.WARN)
else
    mason_lsp.setup({
        ensure_installed = { "lua_ls", "elixirls", "rust_analyzer" },
    })
end
