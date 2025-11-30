local ok, neogit = pcall(require, "neogit")
if not ok then
    vim.notify("neogit is not installed!", vim.log.levels.WARN)
    return
end

local ok_plenary, _ = pcall(require, "plenary")
if not ok_plenary then
    vim.notify("plenary.nvim is not installed!", vim.log.levels.WARN)
end

local ok_diffview, _ = pcall(require, "diffview")
if not ok_diffview then
    vim.notify("diffview.nvim is not installed!", vim.log.levels.WARN)
end

local ok_telescope, _ = pcall(require, "telescope")
if not ok_telescope then
    vim.notify("telescope.nvim is not installed!", vim.log.levels.WARN)
end

vim.keymap.set("n", "<leader>gh", function()
    neogit.open()
end, { desc = "open neogit" })
