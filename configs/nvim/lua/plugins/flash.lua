local ok, flash = pcall(require, "flash")
if not ok then
  vim.notify("flash.nvim not installed!", vim.log.levels.WARN)
  return
end

flash.setup({})

local map = vim.keymap.set

map({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "Æ", function() flash.treesitter() end, { desc = "Flash Treesitter" })
map("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
map("c", "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
