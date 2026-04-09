local ok, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not ok then
    vim.notify("gruvbox colorscheme is not installed!", vim.log.levels.WARN)
end
