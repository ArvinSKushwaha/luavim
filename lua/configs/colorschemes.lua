
--[[---------------------------------------]]--
--    colorscheme - tokyonight colorscheme   --
--               Author: elai                --
--              License: GPLv3               --
--[[---------------------------------------]]--

-- vim.g.nord_contrast = true
-- vim.g.nord_borders = false
-- vim.g.nord_disable_background = true
-- vim.g.nord_italic = false

-- Load the colorscheme

-- local catppuccin = require('catppuccin')
-- catppuccin.setup()
-- vim.g.catppuccin_flavour = "mocha"

vim.g.tokyonight_transparent = true
vim.g.tokyonight_colors = {
    comment = "green2"
}

local colorscheme = "tokyonight-night"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
