local ok, trouble = pcall(require, "trouble")
if not ok then
    vim.notify("trouble.nvim is not installed!", vim.log.levels.WARN)
    return
end

trouble.setup({
    position = "right",
})

local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>TroubleToggle lsp_document_symbols<CR>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>TroubleToggle lsp_definitions<CR>", { desc = "LSP Definitions / references / ... (Trouble)" })
map("n", "<leader>xL", "<cmd>TroubleToggle loclist<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<CR>", { desc = "Quickfix List (Trouble)" })
