
local ok, dashboard = pcall(require, "dashboard")
if not ok then
    vim.notify("dashboard-nvim is not installed!", vim.log.levels.WARN)
    return
end

dashboard.setup({
})

local ok_icons, _ = pcall(require, "nvim-web-devicons")
if not ok_icons then
    vim.notify("nvim-web-devicons is not installed!", vim.log.levels.WARN)
end
