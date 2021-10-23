pcall(require, "luarocks.loader")

local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("modules.helpers")
local gfs = require("gears.filesystem")

require("awful.autofocus")

-- Error on startup notification:
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "An error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)


-- Initialize selected theme.
local themes_path = gfs.get_configuration_dir()
beautiful.init(themes_path .. "settings/themes/nightfall.lua")


-- garbage collector
collectgarbage("step", 1024)
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)


-- modifiers
modkey = "Mod4"
winkey = "Mod1"
shiftkey = "Shift"
controlkey = "Control"


-- Load external modules
local bling = require("modules.bling")

local tile = awful.layout.suit.tile
local floating = awful.layout.suit.floating
local vertical = bling.layout.vertical
local centered = bling.layout.centered

awful.layout.layouts = {
    floating, tile, vertical, centered
}

local gap_size = beautiful.useless_gap

-- Define tag names
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag.add("code", {
        gap = 10,
        screem = s,
        layout = tile,
    })
    awful.tag.add("music", {
        gap = gap_size,
        screem = s,
        layout = floating,
    })
    awful.tag.add("home", {
        gap = gap_size,
        screen = s,
        selected = true,
        layout = floating,
    })
    awful.tag.add("web", {
        gap = gap_size,
        screen = s,
        layout = tile,
    })
    awful.tag.add("chat", {
        gap = gap_size,
        screem = s,
        layout = floating,
    })
end)

-- Focus on click
client.connect_signal("focus",
    function(c)
        c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
end)

-- Enable sloppy focus, so that focus follows mouse.
--[[
client.connect_signal("mouse::enter", function(c)--
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--]]

-- Load modules
require("settings")
require("modules.savefloats")
require("modules.placement")
require("modules.autostart")
