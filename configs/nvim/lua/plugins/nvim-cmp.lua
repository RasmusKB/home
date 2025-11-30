local ok, cmp = pcall(require, "cmp")
if not ok then
    vim.notify("nvim-cmp is not installed!", vim.log.levels.WARN)
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            if vim.snippet and vim.snippet.expand then
                vim.snippet.expand(args.body)
            end
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet and vim.snippet.active and vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet and vim.snippet.active and vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    }),
})
