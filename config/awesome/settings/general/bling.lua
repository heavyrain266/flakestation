local awful = require("awful")
local bling = require("modules.bling")
local rubato = require("modules.rubato")

local anim_y = rubato.timed {
    pos = 1090,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true
}

local anim_x = rubato.timed {
    pos = -970,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true
}

local term_scratch = bling.module.scratchpad {
     command = "wezterm start --class spad",
     rule = { instance = "spad" },
     sticky = true,
     autoclose = true,
     floating = true,
     geometry = {x=360, y=90, height=900, width=1200}, 
     reapply = true,
     dont_focus_before_close  = false,
     rubato = {x = anim_x, y = anim_y}
}

bling.widget.window_switcher.enable {
    type = "thumbnail",

    hide_window_switcher_key = "Escape",
    minimize_key = "n",
    unminimize_key = "N",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Left",
    next_key = "Right",
    vim_previous_key = "h",
    vim_next_key = "l",
}


-- Bling related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = { modkey },
        key = "t",
        group = "Bling",
        description = "Enable tabbed mode",
        on_press = function()
            bling.module.tabbed.pick()
        end,
    },
    awful.key {
        modifiers = { modkey, shiftkey },
        key = "t",
        group = "Bling",
        description = "Remove window from tabbed mode",
        on_press = function()
            bling.module.tabbed.pop()
        end,
    },
    awful.key {
        modifiers = { winkey },
        key = "Tab",
        group = "Bling",
        description = "Enable window switcher",
        on_press = function()
            awesome.emit_signal("bling::window_switcher::turn_on")
        end,
    },
    awful.key {
        modifiers = { winkey },
        key = "a",
        group = "Bling",
        description = "Enable scratchpad",
        on_press = function()
            term_scratch:toggle()
        end,
    },
})
