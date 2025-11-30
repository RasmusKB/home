local ok_surround, nvim_surround = pcall(require, "nvim-surround")
if not ok_surround then
    vim.notify("nvim-surround is not installed!", vim.log.levels.WARN)
else
    nvim_surround.setup({
    })
end

local ok_floaterm, _ = pcall(require, "floaterm")
if not ok_floaterm then
    vim.notify("vim-floaterm is not installed!", vim.log.levels.WARN)
else
    vim.keymap.set({ "n", "t" }, "<leader>ft", "<cmd>FloatermToggle<CR>", { desc = "Toggle Floaterm" })
end

local ok_icons, mini_icons = pcall(require, "mini.icons")
if not ok_icons then
    vim.notify("mini.icons is not installed!", vim.log.levels.WARN)
else
    mini_icons.setup({
        file = {
            [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
            ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        },
        filetype = {
            dotenv = { glyph = "", hl = "MiniIconsYellow" },
        },
    })

    package.preload["nvim-web-devicons"] = function()
        mini_icons.mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
    end
end

local ok_snacks, snacks = pcall(require, "snacks")
if not ok_snacks then
    vim.notify("snacks.nvim is not installed!", vim.log.levels.WARN)
else
    snacks.setup({
        indent = { enabled = true },
        scope = { enabled = true },
    })
end
