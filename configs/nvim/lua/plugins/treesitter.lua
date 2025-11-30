local ok_ts, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ok_ts then
    vim.notify("nvim-treesitter is not installed!", vim.log.levels.WARN)
else
    ts_configs.setup({
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "python",
            "javascript",
        },
        highlight = {
            enable = true,
        },
    })
end

local ok_rainbow, rainbow = pcall(require, "rainbow-delimiters")
if not ok_rainbow then
    vim.notify("rainbow-delimiters.nvim is not installed!", vim.log.levels.WARN)
else
    vim.cmd [[
        highlight RainbowDelimiterRed     guifg=#fb4934
        highlight RainbowDelimiterOrange  guifg=#fe8019
        highlight RainbowDelimiterYellow  guifg=#fabd2f
        highlight RainbowDelimiterGreen   guifg=#b8bb26
        highlight RainbowDelimiterAqua    guifg=#8ec07c
        highlight RainbowDelimiterBlue    guifg=#83a598
        highlight RainbowDelimiterPurple  guifg=#d3869b
    ]]

    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow.strategy['global'],
        },
        query = {
            [''] = 'rainbow-delimiters',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterOrange',
            'RainbowDelimiterYellow',
            'RainbowDelimiterGreen',
            'RainbowDelimiterAqua',
            'RainbowDelimiterBlue',
            'RainbowDelimiterPurple',
        },
    }
end
