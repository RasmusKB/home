local ok, lualine = pcall(require, "lualine")
if not ok then
    vim.notify("lualine.nvim is not installed!", vim.log.levels.WARN)
    return
end

local ok_icons, _ = pcall(require, "nvim-web-devicons")
if not ok_icons then
    vim.notify("nvim-web-devicons is not installed!", vim.log.levels.WARN)
end

local function clock()
    return " " .. os.date("%R")
end

local function root_dir()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

lualine.setup({
    options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter", "lazy" },
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            root_dir,
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn  = " ",
                    info  = " ",
                    hint  = " ",
                },
            },
            {
                "filetype",
                icon_only = true,
                separator = "",
                padding = { left = 1, right = 0 },
            },
            {
                "filename",
                path = 1,
                symbols = {
                    modified = " ●",
                    readonly = " ",
                    unnamed = "",
                },
            },
        },
        lualine_x = {
            {
                "diff",
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
        },
        lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = { clock },
    },
    extensions = { "nvim-tree", "quickfix", "fzf" },
})
