-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


local function double_screen_setup()
end


local function num_screens()
   local res = 0
   for s in screen do
      res = res  +1
   end
   return res
end


local function setTitlebar(c, f)
   if f then
      if c.titlebar == nil then
         c:emit_signal("request::titlebars", "rules", {})
      end
      awful.titlebar.show(c)
   else
      awful.titlebar.hide(c)
   end
end


local function single_screen_setup()
end



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- Colors

local background = "#33393b"
local foreground = "#eff0eb"

local black = "#33393B"
local black_light = "#4f4b58"
local white = "#eff0eb"
local white_light = "#ffffff"
local red = "#ff697b"
local red_light = "#ef9a9a"
-- local yellow
local yellow_light = "#fff9c4"
-- local green
-- local green_light
-- local cyan
-- local cyan_light
local blue = "#00b8d4"
local blue_light = "#4dd0e1"
-- local magenta
-- local magenta_light

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(
   gears.filesystem.get_themes_dir().."default/theme.lua"
)

icons_path = os.getenv("HOME").."/.config/awesome/icons/"

-- Overrides default theme
beautiful.bg_normal = black_light
beautiful.bg_focus = black_light
beautiful.bg_systray = black_light
beautiful.bg_urgent = black_light

beautiful.fg_normal = foreground
beautiful.fg_focus = foreground

beautiful.useless_gap = 3
beautiful.border_width = 2

beautiful.titlebar_bg = background
beautiful.titlebar_fg_normal = background
beautiful.titlebar_fg_focus = foreground

beautiful.awesome_icon = icons_path.."icons8-moon-phase-64.png"

beautiful.titlebar_close_button_normal = icons_path.."close-icon-normal.svg"
beautiful.titlebar_close_button_focus = icons_path.."circle-outline-red.svg"

-- Background
beautiful.wallpaper = "/home/kremor/.config/awesome/background.png"

-- Hover
beautiful.titlebar_close_button_normal_hover = icons_path.."close-icon.svg"
beautiful.titlebar_close_button_focus_hover = icons_path.."close-icon.svg"

beautiful.taglist_square_size = nil
beautiful.taglist_squares_sel = nil
beautiful.taglist_squares_unsel = nil


-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.spiral.dwindle,
   awful.layout.suit.tile,
   awful.layout.suit.fair,
   awful.layout.suit.max,
   awful.layout.suit.magnifier,
   awful.layout.suit.floating,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
   -- awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
      items = {
         { "awesome", myawesomemenu, beautiful.awesome_icon },
         { "open terminal", terminal },
         { "open emacs", "emacsclient -c -a=''" },
         { "open firefox", "firefox" },
      }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
               c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
         end
   end),
   awful.button({ }, 3, client_menu_toggle_fn()),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- local screen_count = num_screens()
    -- local tags_per_screen = 10 // screen_count

    -- for i = 1,  do
    --    local ii = (s.index - 1) * screen_count + i
    --    awful.tag.add(
    --       string.format("tag %d", ii),
    --       {
    --          icon = icons_path.."circle-outline-white.svg",
    --          layout = awful.layout.layouts[1],
    --          gap_single_client = true,
    --          gap = 3,
    --          sceen = s,
    --          selected = false
    --       }
    --    )
    -- end

    -- Each screen has its own tag table.
    tags = {}
    for i = 1, 5 do
       tags[i] = ""
    end
    awful.tag(
       tags,
       s,
       awful.layout.layouts[1]
    )

    for i = 1, 5 do
       local tag = s.tags[i]
       tag.gap = 3
       tag.gap_single_client = true
       tag.icon = icons_path.."circle-outline-white.svg"
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which
    -- layout we're using. We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
       gears.table.join(
          awful.button({ }, 1, function () awful.layout.inc( 1) end),
          awful.button({ }, 3, function () awful.layout.inc(-1) end),
          awful.button({ }, 4, function () awful.layout.inc( 1) end),
          awful.button({ }, 5, function () awful.layout.inc(-1) end)
       )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(
       s,
       awful.widget.taglist.filter.all,
       taglist_buttons
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
       s,
       awful.widget.tasklist.filter.currenttags,
       tasklist_buttons
    )

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    systray = wibox.widget.systray()
    systray:set_base_size(20)
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            systray,
            mytextclock,
            s.mylayoutbox,
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key(
       { modkey, }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {
           description = "focus next by index",
           group = "client"
        }
    ),
    awful.key(
       { modkey, }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {
           description = "focus previous by index",
           group = "client"
        }
    ),
    awful.key(
       { modkey, }, "w",
       function () mymainmenu:show() end,
       {
          description = "show main menu",
          group = "awesome"
       }
    ),

    -- Centers floating window
    awful.key(
       { modkey, }, "c",
       function(c)
          awful.placement.centered(c, {honor_workarea=true})
       end,
       {
          description = "Centers floating window",
          group = "client"
       }
    ),

    -- Layout manipulation
    awful.key(
       { modkey, "Shift" }, "j",
       function () awful.client.swap.byidx(1) end,
       {
          description = "swap with next client by index",
          group = "client"}
    ),
    awful.key(
       { modkey, "Shift" }, "k",
       function () awful.client.swap.byidx(-1) end,
       {
          description = "swap with previous client by index",
          group = "client"}
    ),
    awful.key(
       { modkey, "Control" }, "j",
       function () awful.screen.focus_relative( 1) end,
       {
          description = "focus the next screen",
          group = "screen"}
    ),
    awful.key(
       { modkey, "Control" }, "k",
       function () awful.screen.focus_relative(-1) end,
       {
          description = "focus the previous screen",
          group = "screen"}
    ),
    awful.key(
       { modkey, }, "u",
       awful.client.urgent.jumpto,
       {
          description = "jump to urgent client",
          group = "client"}
    ),
    awful.key(
       { modkey, }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key(
       { modkey, },
       "Return",
       function () awful.spawn(terminal) end,
       {description = "open a terminal", group = "launcher"}
    ),
    -- rofi
    awful.key(
       { modkey, },
       "space",
       function ()
          awful.spawn(
             "rofi -show combi"
          )
       end,
       { description = "open rofi", group = "launcher" }
    ),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
       {description = "quit awesome", group = "awesome"}),
    -- awful.key({ modkey, }, "space", function () awful.spawn("rofi") end,
    --    {description = "open rofi", group = "launcher"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
       {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
       { modkey, }, ",",
       function () awful.layout.inc(-1) end,
       { description = "select previous", group = "layout" }
    ),
    awful.key(
       { modkey, }, ".",
       function () awful.layout.inc(1) end,
       {description = "select next", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key(
      { modkey, }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}
   ),
   awful.key(
      { modkey, }, "q",
      function (c) c:kill() end,
      {description = "close", group = "client"}
   ),
   awful.key(
      { modkey, "Shift"  }, "f",
      function (c)
         c.floating = not c.floating
      end,
      {description = "toggle floating", group = "client"}
   ),
   awful.key(
      { modkey, "Control" }, "Return",
      function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}
   ),
   awful.key(
      { modkey, }, "o",
      function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}
   ),
   awful.key(
      { modkey,           }, "t",
      function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local screen_count = num_screens()
local tags_per_screen = 10 // screen_count
local total_tags = tags_per_screen * screen_count

for i = 1, 10 do
   local index = i
   local screen_index = i // 6 + 1
   if index > 5 then
      index = index - 5
   end
   globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
         function ()
            awful.screen.focus(screen_index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
               tag:view_only()
            end
         end,
         {description = "view tag #"..i, group = "tag"}
      ),
      -- Move window to tag
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
         function ()
            if client.focus then
               for s in screen do
                  if s.index == screen_index then
                     local tag = s.tags[index]
                     client.focus:move_to_tag(tag)
                  end
               end
            end
         end,
         {description = "move client tag #"..i, group = "tag" }
      )
   )
end
      -- -- Toggle tag display.
      -- awful.key({ modkey, "Control" }, "#" .. i + 9,
      --             function ()
      --                 local screen = awful.screen.focused()
      --                 local tag = screen.tags[i]
      --                 if tag then
      --                    awful.tag.viewtoggle(tag)
      --                 end
      --             end,
      --             {description = "toggle tag #" .. i, group = "tag"}),
      --   -- Move client to tag.
      --   awful.key({ modkey, "Shift" }, "#" .. i + 9,
      --             function ()
      --                 if client.focus then
      --                     local tag = client.focus.screen.tags[i]
      --                     if tag then
      --                         client.focus:move_to_tag(tag)
      --                     end
      --                end
      --             end,
      --             {description = "move focused client to tag #"..i, group = "tag"}),
      --   -- Toggle tag on focused client.
      --   awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      --             function ()
      --                 if client.focus then
      --                     local tag = client.focus.screen.tags[i]
      --                     if tag then
      --                         client.focus:toggle_tag(tag)
      --                     end
      --                 end
      --             end,
      --             {description = "toggle focused client on tag #" .. i, group = "tag"})
--   )
-- end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 2,
                     border_color = "#8ABDF2",
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
tag.connect_signal(
   "property::useless_gap*",
   function (t)
      t.gap_single_client = true
      local count = 0
      for _ in pairs(t:clients()) do
         count = count + 1
      end
      if count == 1 then
         return 10
      else
         return 3
      end
   end
)

-- Adds a title bar to all the clients if the layout is changed to floating

-- Changes floating property
client.connect_signal(
   "property::floating",
   function (c)
      setTitlebar(c, c.floating)
   end
)

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function (c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.

      -- Adds titlebar if window is in floating mode
      setTitlebar(
         c,
         c.floating or c.first_tag.layout == awful.layout.suit.floating
      )

      -- Adds round corners
      c.shape = function(cr, w, h)
         gears.shape.rounded_rect(cr, w, h, 6)
      end

      -- Sets new window as slave
      awful.client.setslave(c)

      if awesome.startup and
         not c.size_hints.user_position
      and not c.size_hints.program_position then
         -- Prevent clients from being unreachable after screen count changes.
         awful.placement.no_offscreen(c)
      end

      -- Icon
      local client_count = 0
      local t = c.first_tag

      for _ in pairs(t:clients()) do
         client_count = client_count + 1
      end

      if client_count > 0 then
         t.icon = icons_path.."circle-blue-light.svg"
      else
         t.icon = icons_path.."close-icon-focus.svg"
      end
   end
)

client.connect_signal(
   "unmanage",
   function (c)
      local client_count = 0

      local t = awful.screen.focused().selected_tag

      for _ in pairs(t:clients()) do
         client_count = client_count + 1
      end

      if client_count > 0 then
         t.icon = icons_path.."circle-blue-light.svg"
      else
         t.icon = icons_path.."close-icon-focus.svg"
      end
   end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            -- awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal(
   "focus",
   function(c)
      c.border_color = blue_light
   end
)

client.connect_signal(
   "unfocus",
   function(c)
      c.border_color = black
   end
)

tag.connect_signal(
   "property::selected",
   function (t)
      local client_count = 0

      for _ in pairs(t:clients()) do
         client_count = client_count + 1
      end

      if t.selected then
         if client_count > 0 then
            t.icon = icons_path.."circle-blue-light.svg"
         else
            t.icon = icons_path.."close-icon-focus.svg"
         end
      else
         if client_count > 0 then
            t.icon = icons_path.."circle-outline-blue-light.svg"
         else
            t.icon = icons_path.."circle-outline-white.svg"
         end
      end
   end
)

client.connect_signal(
   "property::urgent",
   function (c)
      for _, t in pairs(c:tags()) do
         if t.selected then
            t.icon = icons_path.."close-icon.svg"
         else
            t.icon = icons_path.."circle-outline-red.svg"
         end
      end
   end
)
-- }}}

awful.spawn.with_shell("$HOME/.local/bin/init.fish")
