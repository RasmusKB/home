local ok, bufferline = pcall(require, "bufferline")
if not ok then
    vim.notify("bufferline.nvim is not installed!", vim.log.levels.WARN)
    return
end

bufferline.setup({
    options = {
        close_command = function(bufnr) vim.api.nvim_buf_delete(bufnr, { force = true }) end,
        right_mouse_command = function(bufnr) vim.api.nvim_buf_delete(bufnr, { force = true }) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diagnostics)
            local icons = {
                Error = " ",
                Warn  = " ",
                Info  = " ",
            }
            local result = ""
            if diagnostics.error then result = result .. icons.Error .. diagnostics.error .. " " end
            if diagnostics.warning then result = result .. icons.Warn .. diagnostics.warning end
            return vim.trim(result)
        end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left",
            },
        },
    },
})

local ok_groups, groups = pcall(require, 'bufferline.groups')
if ok_groups then
    groups.builtin.pinned:with({ icon = "󰐃 " })
else
    vim.notify("bufferline.groups not available!", vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
    callback = function()
        vim.schedule(function()
            pcall(vim.cmd, "BufferLineRefresh")
        end)
    end,
})

local map = vim.keymap.set
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "[B", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev" })
map("n", "]B", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })
