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
        ensure_installed = { "lua_ls", "pyright", "tsserver" },
    })
end

local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then
    vim.notify("nvim-lspconfig is not installed!", vim.log.levels.WARN)
    return
end

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

if lspconfig.pyright then
    lspconfig.pyright.setup({})
end

if lspconfig.tsserver then
    lspconfig.tsserver.setup({})
end
