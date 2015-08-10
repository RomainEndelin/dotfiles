-- vim: fdm=marker

-- {{{ Powerarrow Awesome WM config
-- github.com/copycat-killer
-- }}}

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
local revelation = require("revelation")
local awpomodoro = require("awpomodoro")
local vicious = require("vicious")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("unclutter")
-- }}}

-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/powerarrow/theme.lua")
revelation.init()

font = "Inconsolata 11"

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "termite" or "urxvt" or "xterm"
editor     = os.getenv("EDITOR") or "nano" or "vi"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser    = "firefox"
browser2   = "iron"
gui_editor = "gvim"
graphics   = "gimp"
-- mail       = terminal .. " -e mutt "
iptraf     = terminal .. " -g 180x54-20+34 -e sudo iptraf-ng -i all "
network_tool     = terminal .. " -g 180x54-20+34 -e wicd-curses"
musicplr   = terminal .. " -g 130x34-320+16 -e ncmpcpp "
-- }}}

-- {{{ Tags and layouts
local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
}

tags = {
   names = { "1", "2", "3", "4", "5", "6", "Skype", "Music", "Mail"},
   layout = { layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2] }
}

for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Wallpaper
for s = 1, screen.count() do
    gears.wallpaper.maximized(os.getenv("HOME") .. "/.config/awesome/themes/powerarrow/stars_wallpaper.jpg", s, true)
end
-- if beautiful.wallpaper then
--     for s = 1, screen.count() do
--         gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--     end
-- end
-- }}}

-- {{{ Menu
require("freedesktop/freedesktop")
-- }}}

-- {{{ Wibox
markup = lain.util.markup

-- {{{ Widgets
-- {{{ Textclock
clockimg = wibox.widget.imagebox(beautiful.clock)
clockicon = wibox.widget.background(clockimg, '#777E76')

tclock = wibox.widget.textbox()
textclock = wibox.widget.background(tclock, '#777E76')
textclock:set_fg("#EEEEEE")
local strf = '%a %d %b %H:%M'
vicious.register(tclock, vicious.widgets.date, strf, 20)
-- }}}

-- {{{ Calendar
-- lain.widgets.calendar:attach(textclock, { font_size = 10 })
-- }}}

-- {{{ AwPomodoro
pmdrimg = wibox.widget.imagebox(beautiful.pomodoro)
pmdricon = wibox.widget.background(pmdrimg, '#92B0A0')

pmdr = wibox.widget.background(awpomodoro(), "#92B0A0")
pmdr:set_fg("#EEEEEE")
-- awpomodoro.work_minutes = 25
-- awpomodoro.break_minutes = 5
-- awpomodoro.longbreak_minutes = 20
-- awpomodoro.work_tag = ...
-- awpomodoro.break_tag = ...
-- awpomodoro.longbreak_tag = ...

-- SIGNALS:
-- awpomodoro::work_end
-- awpomodoro::break_end
-- awpomodoro::toggle
-- }}}

-- {{{ MPD
mpdimg = wibox.widget.imagebox(beautiful.widget_music)
mpdicon = wibox.widget.background(mpdimg, '#4B3B51')
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplr) end)))

mpdwidget = lain.widgets.mpd({
    settings = function()
        max_title_len = 20
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            if string.len(title) > max_title_len then
                title = string.sub(title, 1, max_title_len - 3) .. "..."
            end
            mpdimg:set_image(beautiful.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdimg:set_image(beautiful.widget_music)
        end

        widget:set_markup(markup("#EA6F81", artist) .. title)
    end
})
mpdwidgetbg = wibox.widget.background(mpdwidget, "#4B3B51")
mpdwidgetbg:set_fg('#EEEEEE')
-- }}}

-- {{{ Memory
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, '<span background="#777E76" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE" background="#777E76">$1% ($2MB) </span></span>', 20)

memicon = wibox.widget.imagebox(beautiful.mem)
memicon = wibox.widget.background(memicon, "#777E76")
-- }}}

-- {{{ CPU
cpuicon = wibox.widget.imagebox(beautiful.cpuicon)
cpuicon = wibox.widget.background(cpuicon, "#4B696D")
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu,
'<span background="#4B696D" font="Inconsolata 11"> <span font="Inconsolata 11" color="#DDDDDD">$1% [$2% - $3% - $4% - $5%] </span></span>', 5)
-- }}}

-- {{{ Gmail
-- mailimg = wibox.widget.imagebox()
-- mailicon = wibox.widget.background(mailimg, "#4B696D")

-- vicious.register(mailimg, vicious.widgets.gmail, function(widget, args)
--     local newMail = tonumber(args["{count}"])
--     if newMail > 0 then
--         mailimg:set_image(beautiful.mailopen)
--     else
--         mailimg:set_image(beautiful.mail)
--     end
-- end, 15)
-- -- to make GMail pop up when pressed:
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1,
-- function () awful.util.spawn_with_shell(browser .. " gmail.com") end)))
-- }}}

-- {{{ Coretemp
tempwidget1 = wibox.widget.textbox()
vicious.register(tempwidget1, vicious.widgets.thermal, '<span background="#777E76" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE" background="#777E76">$1°C - </span></span>', 20, { "thermal_zone0", "sys" })
tempwidget2 = wibox.widget.textbox()
vicious.register(tempwidget2, vicious.widgets.thermal, '<span background="#777E76" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE" background="#777E76">$1°C </span></span>', 20, { "thermal_zone1", "sys" })
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
-- }}}

-- {{{ Filesystem
fsicon = wibox.widget.imagebox(beautiful.fsicon)

fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs,
'<span background="#D0785D" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE">${/home used_gb}/${/home avail_gb} GB </span></span>',
800)
-- }}}

-- {{{ Battery
baticon = wibox.widget.imagebox(beautiful.battery)
baticon = wibox.widget.background(baticon, '#C2C2A4')

battery = wibox.widget.textbox()
batwidget = wibox.widget.background(battery, '#C2C2A4')
batwidget:set_fg("#EEEEEE")
local strf = '$1$2% ($3) '
vicious.register(battery, vicious.widgets.bat, strf, 30, "BAT0")
-- }}}

-- {{{ ALSA volume
volimg = wibox.widget.imagebox()
volicon = wibox.widget.background(volimg, '#D0785D')

voltext = wibox.widget.textbox()
volumewidget = wibox.widget.background(voltext, "#D0785D")
volumewidget:set_fg('#EEEEEE')
vicious.register(voltext, vicious.widgets.volume, function(widget, args)

        vol = args[1]
        if args[2] == "♩" then
            volimg:set_image(beautiful.mute)
        elseif vol >= 67 and vol <= 100 then
            volimg:set_image(beautiful.volhi)
        elseif vol >= 33 and vol <= 66 then
            volimg:set_image(beautiful.volmed)
        else
            volimg:set_image(beautiful.vollow)
        end
    return vol ..'♩ '
end, 1, "Master")
-- }}}

-- {{{ Packages
pkgwidget = wibox.widget.textbox()
vicious.register(pkgwidget, vicious.widgets.pkg,
'<span background="#D0785D" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE">PKGS: $1 </span></span>', 800, "Arch")
-- }}}

-- {{{ Uptime
uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget, vicious.widgets.uptime,
    function (widget, args)
        return string.format("Uptime: %2d days, %02d:%02d ", args[1], args[2], args[3])
    end, 10)
-- }}}

-- {{{ OS
oswidget = wibox.widget.textbox()
vicious.register(oswidget, vicious.widgets.os,
'<span background="#D0785D" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE">$3@$4 - $1:$2</span></span>')
-- }}}

-- {{{ Net
neticon = wibox.widget.imagebox(beautiful.net)
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(network_tool) end)))
-- neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(iptraf) end)))
netwidget = wibox.widget.background(lain.widgets.net({
    settings = function()
        widget:set_markup(markup("#FFFFFF", " " .. net_now.received)
                          .. " " ..
                          markup("#46A8C3", " " .. net_now.sent .. " "))
    end
}), "#C2C2A4")
-- }}}

-- {{{ Wifi
wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi,
'<span background="#D0785D" font="Inconsolata 11"> <span font="Inconsolata 11" color="#EEEEEE"> ${ssid} (${link}%) </span></span>', 3, "wlp2s0")
-- }}}

-- }}}

-- {{{ Wibox creation
-- {{{ Separators
spr = wibox.widget.textbox(' ')

arr_orange = wibox.widget.imagebox(beautiful.arr_to_orange)
arr_pmdr_vol = wibox.widget.background(arr_orange, '#92B0A0')
arr_pmdr_vol.width = 10
arr1 = wibox.widget.imagebox()
arr1:set_image(beautiful.arr1)
arr2 = wibox.widget.imagebox()
arr2:set_image(beautiful.arr2)
arr3 = wibox.widget.imagebox()
arr3:set_image(beautiful.arr3)
arr4 = wibox.widget.imagebox()
arr4:set_image(beautiful.arr4)
arr5 = wibox.widget.imagebox()
arr5:set_image(beautiful.arr5)
arr6 = wibox.widget.imagebox()
arr6:set_image(beautiful.arr6)
arr7 = wibox.widget.imagebox()
arr7:set_image(beautiful.arr7)
arr8 = wibox.widget.imagebox()
arr8:set_image(beautiful.arr8)
arr9 = wibox.widget.imagebox()
arr9:set_image(beautiful.arr9)
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
-- }}}

-- Create a wibox for each screen and add it
mywibox = {}
bottom_wibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ theme = { width = 251 } })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- {{{ Top Wibox
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spr)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(spr)

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(arrl)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(arr9)
    -- right_layout:add(mailicon)
    right_layout:add(arr6)
    right_layout:add(mpdicon)
    right_layout:add(mpdwidgetbg)
    right_layout:add(arr5)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    -- right_layout:add(arr4)
    right_layout:add(arr_pmdr_vol)
    right_layout:add(pmdricon)
    right_layout:add(pmdr)
    right_layout:add(arr3)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(arr2)
    right_layout:add(clockicon)
    right_layout:add(textclock)
    right_layout:add(arr1)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
    -- }}}

    -- {{{ Bottom Wibox
    bottom_wibox[s] = awful.wibox({ position = "bottom", screen = s, height = 16 })
    local bottom_layout = wibox.layout.align.horizontal()

    local bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(oswidget)
    bottom_left_layout:add(arr2)
    bottom_left_layout:add(pkgwidget)
    bottom_left_layout:add(arr3)
    bottom_left_layout:add(uptimewidget)

    local bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(arrl)
    bottom_right_layout:add(memicon)
    bottom_right_layout:add(memwidget)
    bottom_right_layout:add(arr4)
    bottom_right_layout:add(cpuicon)
    bottom_right_layout:add(cpuwidget)
    bottom_right_layout:add(arr3)
    bottom_right_layout:add(tempicon)
    bottom_right_layout:add(tempwidget1)
    bottom_right_layout:add(tempwidget2)
    bottom_right_layout:add(arr2)
    bottom_right_layout:add(fsicon)
    bottom_right_layout:add(fswidget)
    bottom_right_layout:add(arr1)
    bottom_right_layout:add(neticon)
    bottom_right_layout:add(netwidget)
    bottom_right_layout:add(arr1)
    bottom_right_layout:add(wifiwidget)

    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_right(bottom_right_layout)
    bottom_wibox[s]:set_widget(bottom_layout)
    bottom_wibox[s].visible = false
    -- }}}
end
-- }}}

-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("import") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Revelation
    awful.key({ modkey }, "e", revelation),
    awful.key({ modkey, "Shift" }, "e", function() revelation({rule={class="URxvt"}}) end),
    awful.key({ modkey, "Control" }, "e", function() revelation({rule={class="Firefox"}}) end),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    -- Default client focus
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "[", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),
    awful.key({ modkey }, "]", function ()
        bottom_wibox[mouse.screen].visible = not bottom_wibox[mouse.screen].visible
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey,           }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey,           }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn("cool-retro-term --program cmatrix -a -u 8") end),
    awful.key({ modkey, "Shift"   }, "f", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    -- Tag management
    awful.key({ modkey,           }, ",",    function ()
                    awful.prompt.run({ prompt = "Rename tab: ", text = awful.tag.selected().name, },
                    mypromptbox[mouse.screen].widget,
                    function (s)
                        if not s or #s == 0 then
                            return
                        else
                            awful.tag.selected().name = s
                        end
                    end)
                end),

    awful.key({ modkey,           }, "c",    function ()
                    awful.prompt.run({ prompt = "New tab: " },
                    mypromptbox[mouse.screen].widget,
                    function (s)
                        if not s or #s == 0 then
                            return
                        else
                            awful.tag.add(s)
                        end
                    end)
                end),
    awful.key({ modkey,           }, "d",    function () awful.tag.delete(awful.tag.selected()) end),
    awful.key({ modkey, "Shift"   }, ".", function ()
                awful.tag.move(awful.tag.getidx(awful.tag.selected()) + 1, awful.tag.selected())
              end),
    awful.key({ modkey, "Shift"   }, ",", function ()
                awful.tag.move(awful.tag.getidx(awful.tag.selected()) - 1, awful.tag.selected())
              end),
    -- awful.key({ modkey, "Shift"   }, 'o', function ()
    --             awful.tag.setscreen(awful.tag.selected(), (awful.tag.getscreen(awful.tag.selected()) + 1) % (screen.count() + 1))
    --           end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            -- awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle")
            awful.util.spawn_with_shell("playerctl play-pause")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            -- awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop")
            awful.util.spawn_with_shell("playerctl stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            -- awful.util.spawn_with_shell("mpc prev || ncmpcpp prev || ncmpc prev || pms prev")
            awful.util.spawn_with_shell("playerctl previous")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            -- awful.util.spawn_with_shell("mpc next || ncmpcpp next || ncmpc next || pms next")
            awful.util.spawn_with_shell("playerctl next")
            mpdwidget.update()
        end),

    -- Copy to clipboard
    awful.key({ modkey, "Control", "Shift" }, "c", function () os.execute('xclip -o -selection "primary" | xclip -i -selection "clipboard"') end),
    awful.key({ modkey, "Control" }, "c", function () os.execute('xclip -o -selection "clipboard" | xclip -i -selection "primary"') end),

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Shift" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tag then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tag then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },
    { rule = { class = "URxvt" },
          properties = { opacity = 0.99 } },
    { rule = { class = "cool-retro-term" },
          properties = { floating = true, fullscreen = true } },

    { rule = { class = "MPlayer" },
          properties = { floating = true } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
    { rule = { instance = "plugin-container" },
          properties = { floating = true, fullscreen = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_width = 0
            c.border_color = beautiful.border_normal
        else
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width

                -- No borders with only one visible client
                elseif #clients == 1 or layout == "max" then
                    clients[1].border_width = 0
                    awful.client.moveresize(0, 0, 2, 2, clients[1])
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}

