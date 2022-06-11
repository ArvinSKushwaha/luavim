
--[[--------------------------------------]]--
--       nneoscroll - smooth scrolling      --
--              Author: elai                --
--             License: GPLv3               --
--[[--------------------------------------]]--

require('neoscroll').setup({
    pre_hook = function(info) if info == "cursorline" then vim.wo.cursorline = false end end,
    post_hook = function(info) if info == "cursorline" then vim.wo.cursorline = true end end
})

local t = {}

-- Use the "circular" easing function
t['<A-u>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200', [['sine']]}}
t['<A-d>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200', [['sine']]}}

-- Pass "nil" to disable the easing animation (constant scrolling speed)
t['<A-k>'] = {'scroll', {'-vim.wo.scroll', 'false', '150', [['sine']]}}
t['<A-j>'] = {'scroll', { 'vim.wo.scroll', 'false', '150', [['sine']]}}

-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t['zz'] = {'zz', {'200'}}
t['zb'] = {'zb', {'200'}}
t['zt'] = {'zt', {'200'}}

require('neoscroll.config').set_mappings(t)
