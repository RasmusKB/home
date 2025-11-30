vim.g.mapleader = " "
-- Shortcuts for navigating different windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Remove arrow keys in different modes
local nop_opts = { noremap = true, silent = true }
-- Command-line mode
vim.keymap.set('c', '<Down>', '<Nop>', nop_opts)
vim.keymap.set('c', '<Left>', '<Nop>', nop_opts)
vim.keymap.set('c', '<Right>', '<Nop>', nop_opts)
vim.keymap.set('c', '<Up>', '<Nop>', nop_opts)
-- Insert mode
vim.keymap.set('i', '<Down>', '<Nop>', nop_opts)
vim.keymap.set('i', '<Left>', '<Nop>', nop_opts)
vim.keymap.set('i', '<Right>', '<Nop>', nop_opts)
vim.keymap.set('i', '<Up>', '<Nop>', nop_opts)
-- Normal mode
vim.keymap.set('n', '<Down>', '<Nop>', nop_opts)
vim.keymap.set('n', '<Left>', '<Nop>', nop_opts)
vim.keymap.set('n', '<Right>', '<Nop>', nop_opts)
vim.keymap.set('n', '<Up>', '<Nop>', nop_opts)
-- Visual mode
vim.keymap.set('v', '<Down>', '<Nop>', nop_opts)
vim.keymap.set('v', '<Left>', '<Nop>', nop_opts)
vim.keymap.set('v', '<Right>', '<Nop>', nop_opts)
vim.keymap.set('v', '<Up>', '<Nop>', nop_opts)
local group = vim.api.nvim_create_augroup("SeriouslyNoInsertArrows", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function()
    vim.keymap.set("i", "<Up>", function()
      return vim.fn.pumvisible() == 1 and "<C-p>" or ""
    end, { expr = true, noremap = true, silent = true, buffer = true })
  end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function()
    vim.keymap.set("i", "<Down>", function()
      return vim.fn.pumvisible() == 1 and "<C-n>" or ""
    end, { expr = true, noremap = true, silent = true, buffer = true })
  end,
})
-- Linebreak-aware navigation
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true, desc = 'Down (wrapped line)' })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true, desc = 'Up (wrapped line)' })
vim.keymap.set('n', '0', 'g0i', { noremap = true, silent = true, desc = 'Start of wrapped line + insert' })
vim.keymap.set('n', '$', 'g$', { noremap = true, silent = true, desc = 'End of wrapped line' })

-- Remove auto commenting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
-- Automatically delete all trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})

-- Save file as sudo when needed
vim.keymap.set('c', 'w!!', function()
  vim.cmd([[execute 'silent! write !sudo tee % >/dev/null' | edit!]])
end, { noremap = true, desc = 'Save with sudo' })

-- Misc settings
vim.opt.clipboard:append("unnamedplus")    -- Use system clipboard
vim.o.compatible = false                   -- Not necessary in Neovim, but safe
vim.o.splitbelow = true                    -- Horizontal splits below
vim.o.splitright = true                    -- Vertical splits to the right
vim.o.showmode = false                     -- Don't show mode (already in statusline)
vim.o.ignorecase = true                    -- Case-insensitive search
vim.wo.number = true                       -- Show line numbers

-- Enable filetype plugins and indentation
vim.cmd([[filetype plugin indent on]])

-- Tab settings
vim.o.tabstop = 4            -- Number of visual spaces per TAB
vim.o.softtabstop = 4        -- Tabs feel like 4 spaces
vim.o.shiftwidth = 4         -- Autoindent amount
vim.o.autoindent = true      -- Copy indent from current line when starting a new one

-- Syntax and performance settings
vim.cmd("syntax on")
vim.o.maxmempattern = 10000  -- Increase memory for regex matching
vim.o.redrawtime = 10000     -- Allow more time for syntax highlighting in big files

-- Set C indentation style
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Set F# indentation style
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fsharp",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Enable true color in Neovim
vim.opt.termguicolors = true

-- Don't overwrite clipboard when deleting with `x` or `X`
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'X', '"_x', { noremap = true, silent = true })

-- Don't overwrite clipboard when pasting in visual mode with `p`
vim.keymap.set('x', 'p', 'pgvy', { noremap = true, silent = true })

-- Keybind for opening Alacritty
vim.keymap.set('n', '<C-n>', function()
  vim.fn.jobstart("alacritty", { detach = true })
end, { noremap = true, silent = true, desc = "Open new Alacritty terminal" })
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

require("plugins.bufferline")
require("plugins.colorscheme")
require("plugins.dashboard")
require("plugins.flash")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.misc")
require("plugins.neogit")
require("plugins.noice")
require("plugins.nvim-cmp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.trouble")
