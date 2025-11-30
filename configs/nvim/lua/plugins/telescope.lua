local _, telescope = pcall(require, "telescope")
local telescope_builtin = require('telescope.builtin')
pcall(telescope.load_extension, "file_browser")

pcall(require, "plenary")
pcall(require, "nvim-web-devicons")

telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 10,
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = "  ",
        results_title = false,
        prompt_title = false,
        preview_title = false,
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
            },
            n = {
                ["j"] = "move_selection_next",
                ["k"] = "move_selection_previous",
            },
        },
        options = {
            sort_lastused = true,
            sort_mru = true,
        },
    },
    extensions = {
        file_browser = {
            mappings = {
                i = {
                    ["<C-bs>"] = telescope.extensions.file_browser.actions.goto_parent_dir,
                },
                n = {
                    ["<C-bs>"] = telescope.extensions.file_browser.actions.goto_parent_dir,
                },
            },
        },
    },
})

local map = vim.keymap.set
map("n", "<leader>ff", function() telescope_builtin.find_files() end, { desc = "Find Files" })
map("n", "<leader>fg", function() telescope_builtin.live_grep() end, { desc = "Telescope Grep" })
map("n", "<leader>fb", function() telescope_builtin.buffers() end, { desc = "Telescope buffers" })
map("n", "<leader>fh", function() telescope_builtin.help_tags() end, { desc = "Telescope help tags" })
map("n", "<leader>fv", function()
    telescope.extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h") })
end, { desc = "Telescope file browser" })
