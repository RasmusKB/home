local ok, spectre = pcall(require, "spectre")
if not ok then
    vim.notify("spectre.nvim is not installed!", vim.log.levels.WARN)
    return
end

spectre.setup({
  is_block_ui_break = true
})

vim.keymap.set('n', '<leader>sr', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
