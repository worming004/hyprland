---@diagnostic disable: undefined-global
----------------
-- MONITORS
----------------

hl.monitor({
  output   = "DP-1",
  mode     = "3440x1440",
  position = "3440x0",
  scale    = 1,
})

hl.monitor({
  output   = "DP-2",
  mode     = "3440x1440",
  position = "0x0",
  scale    = 1,
})

hl.monitor({
  output   = "HDMI-A-2",
  mode     = "1920x1080",
  position = "6880x650",
  scale    = 1,
})

----------------
-- PROGRAMS
----------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "wofi --show drun --allow-images --insensitive --gtk-dark"

----------------
-- ENV
----------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

----------------
-- AUTOSTART
----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("kitty", { workspace = "1" })
  -- workspaces seems not to work, commented out
  -- hl.exec_cmd("com.google.Chrome", { workspace = "8" })
  -- hl.exec_cmd("flatpak run com.slack.Slack", { workspace = "9" })
end)

----------------
-- LOOK & FEEL
----------------

hl.config({
  general = {
    gaps_in          = 4,
    gaps_out         = 6,
    border_size      = 1,

    col              = {
      active_border = {
        colors = {
          "rgba(33ccffee)",
          "rgba(00ff99ee)",
        },
        angle = 45,
      },

      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = false,
    allow_tearing    = false,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 10,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },

    glow             = {
      enabled      = true,
      range        = 2,
      render_power = 10,
    }
  },

  animations = {
    enabled = true,
  },
  -- quirks = { prefer_hdr = 1 }
})


----------------
-- ANIMATIONS & CURVES
----------------

hl.curve("quickBezier", {
  type = "bezier",
  points = { { 0, 1 }, { 0, 1 } }
})

hl.curve("slowBezier", {
  type = "bezier",
  points = { { 1, 0 }, { 0.49, 0.9 } }
})

hl.animation({
  leaf    = "windows",
  enabled = true,
  speed   = 7,
  bezier  = "quickBezier"
})

hl.animation({
  leaf    = "windowsIn",
  enabled = true,
  speed   = 5,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "windowsOut",
  enabled = true,
  speed   = 7,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "fade",
  enabled = true,
  speed   = 7,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "workspaces",
  enabled = true,
  speed   = 3,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "specialWorkspace",
  enabled = true,
  speed   = 80,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "border",
  enabled = true,
  speed   = 10,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "borderangle",
  enabled = true,
  speed   = 8,
  bezier  = "quickBezier",
})


hl.animation({
  leaf    = "specialWorkspace",
  enabled = true,
  speed   = 6,
  bezier  = "quickBezier",
})

hl.animation({
  leaf    = "specialWorkspaceOut",
  enabled = true,
  speed   = 6,
  bezier  = "quickBezier",
})

hl.animation({
  leaf = "zoomFactor",
  enabled = true,
  speed = 90,
  bezier = "slowBezier"
})

----------------
-- LAYOUTS
----------------

hl.config({
  dwindle = {
    preserve_split = false,
    smart_split    = true,
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

----------------
-- MISC
----------------

hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = false,
  },
})

----------------
-- INPUT
----------------

hl.config({
  input = {
    kb_layout            = "us,be",
    kb_options           = "grp:lctrl_lwin_toggle",
    repeat_delay         = 180,
    repeat_rate          = 50,
    follow_mouse         = 1,
    sensitivity          = 0,
    resolve_binds_by_sym = 1,
    numlock_by_default   = true,

    touchpad             = {
      natural_scroll = false,
    },
  },
})

hl.device({
  name        = "logitech-mx-anywhere-3",
  sensitivity = -0.2,
})

----------------
-- KEYBINDS
----------------

local mainMod = "ALT"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + C",
  hl.dsp.window.close())

hl.bind(mainMod .. " + SHIFT + M",
  hl.dsp.exit())

hl.bind(mainMod .. " + SHIFT + S",
  hl.dsp.exec_cmd("systemctl suspend"))

hl.bind(mainMod .. " + SHIFT + Q",
  hl.dsp.exec_cmd("shutdown -h now"))

hl.bind(mainMod .. " + CTRL + L",
  hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + E",
  hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + D",
  hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + V",
  hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + P",
  hl.dsp.window.pseudo())

hl.bind(mainMod .. " + G",
  hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + L",
  hl.dsp.exec_cmd("hyprshot -m region"))

----------------
-- FOCUS
----------------

hl.bind(mainMod .. " + H",
  hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + L",
  hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + K",
  hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + J",
  hl.dsp.focus({ direction = "down" }))

----------------
-- MOVE WINDOWS
----------------

hl.bind(mainMod .. " + SHIFT + H",
  hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + SHIFT + L",
  hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + K",
  hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + SHIFT + J",
  hl.dsp.window.move({ direction = "down" }))

----------------
-- WORKSPACES
----------------

for i = 1, 10 do
  local key = i % 10

  hl.bind(mainMod .. " + " .. key,
    hl.dsp.focus({ workspace = i }))

  hl.bind(mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + F",
  hl.dsp.window.fullscreen())

----------------
-- MONITOR MOVE
----------------

-- hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor 0"))
hl.bind(mainMod .. " + X", hl.dsp.workspace.move({ monitor = 0, follow = true }))

-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor 1"))

hl.bind(mainMod .. " + Z", hl.dsp.workspace.move({ monitor = 1, follow = true }))

----------------
-- SCROLL WS
----------------

hl.bind(mainMod .. " + mouse_down",
  hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up",
  hl.dsp.focus({ workspace = "e-1" }))

----------------
-- MOUSE MOVE/RESIZE
----------------

hl.bind(mainMod .. " + mouse:272",
  hl.dsp.window.drag(),
  { mouse = true })

hl.bind(mainMod .. " + mouse:273",
  hl.dsp.window.resize(),
  { mouse = true })

----------------
-- MEDIA KEYS
----------------

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true }
)

hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl s 10%+"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl s 10%-"),
  { locked = true, repeating = true }
)

----------------
-- PLAYERCTL
----------------

hl.bind("XF86AudioNext",
  hl.dsp.exec_cmd("playerctl next"),
  { locked = true })

hl.bind("XF86AudioPause",
  hl.dsp.exec_cmd("playerctl play-pause"),
  { locked = true })

hl.bind("XF86AudioPlay",
  hl.dsp.exec_cmd("playerctl play-pause"),
  { locked = true })

hl.bind("XF86AudioPrev",
  hl.dsp.exec_cmd("playerctl previous"),
  { locked = true })

----------------
-- MISC
----------------

hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("killall waybar || waybar # toggle waybar"))

----------------
-- WINDOW RULES
----------------

hl.window_rule({
  name           = "suppress-maximize-events",

  match          = {
    class = ".*",
  },

  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",

  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  float = true,
  match = {
    class = "imv"
  }
})

---------------
--- SCRATCHPADS
---------------

hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special("filepad"))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("spotipad"))
hl.bind(mainMod .. " + B", hl.dsp.workspace.toggle_special("debug"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.window.move({ workspace = "special:debug" }))
