local ok, noice = pcall(require, "noice")
if not ok then
    vim.notify("noice.nvim is not installed!", vim.log.levels.WARN)
    return
end

local opts = {
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
    },
}

if vim.o.filetype == "lazy" then
    vim.cmd([[messages clear]])
end
noice.setup(opts)

local map = vim.keymap.set
map("c", "<S-Enter>", function()
    noice.redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })
map("n", "<leader>snl", function() noice.cmd("last") end, { desc = "Noice Last Message" })
map("n", "<leader>snh", function() noice.cmd("history") end, { desc = "Noice History" })
map("n", "<leader>sn", function() noice.cmd("all") end, { desc = "Noice All" })
map("n", "<leader>snd", function() noice.cmd("dismiss") end, { desc = "Dismiss All" })
map("n", "<leader>snt", function() noice.cmd("pick") end, { desc = "Noice Picker (Telescope/FzfLua)" })

map({ "i", "n", "s" }, "<c-f>", function()
    if not require("noice.lsp").scroll(4) then return "<c-f>" end
end, { silent = true, expr = true, desc = "Scroll Forward" })

map({ "i", "n", "s" }, "<c-b>", function()
    if not require("noice.lsp").scroll(-4) then return "<c-b>" end
end, { silent = true, expr = true, desc = "Scroll Backward" })
