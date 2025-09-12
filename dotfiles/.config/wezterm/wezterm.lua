local wezterm = require 'wezterm'
local act = wezterm.action
local my_border_color = '#101050'
local my_dracula = wezterm.color.get_builtin_schemes()['Dracula']

-- Get hostname
local f = io.popen '/bin/hostname'
local hostname = f:read '*a' or ''
f:close()
hostname = string.gsub(hostname, '\n$', '')
local my_wayland_enable = true
if hostname == 'pc' then
  my_wayland_enable = false
end

my_dracula.background = '#202020'

if os.getenv 'WEZTERM_EDITOR_LAYOUT' then
  wezterm.on('gui-startup', function(cmd)
    -- Create initial window and pane
    local tab, initial_pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()

    local right_pane = initial_pane:split {
      direction = 'Right',
      size = 0.3,
    }

    local bottom_right = right_pane:split {
      direction = 'Bottom',
      size = 0.25,
    }

    local middle_right = right_pane:split {
      direction = 'Bottom',
      size = 0.6,
    }

    local bottom_left = initial_pane:split {
      direction = 'Bottom',
      size = 0.05,
    }
  end)
end

local config = {
  color_schemes = { ['My Dracula'] = my_dracula },
  font_size = 11,
  font = wezterm.font 'Roboto Mono',
  color_scheme = 'My Dracula',
  tab_bar_at_bottom = true,
  keys = {
    {
      key = 'Insert',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    {
      key = 'f',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = 'h',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'ALT',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = act.SplitPane { direction = 'Left' },
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = act.SplitPane { direction = 'Right' },
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.SplitPane { direction = 'Up' },
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.SplitPane { direction = 'Down' },
    },
    {
      key = 'w',
      mods = 'ALT',
      action = act.CloseCurrentPane { confirm = true },
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Up', 3 },
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Right', 3 },
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Down', 3 },
    },
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Left', 3 },
    },
  },
  initial_rows = 50,
  initial_cols = 104,
  enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = 'Disabled',
  enable_wayland = my_wayland_enable,
  front_end = 'OpenGL',
  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'ssh',
    'btop',
  },
  window_decorations = 'NONE',
  window_frame = {
    border_left_width = '2',
    border_right_width = '2',
    border_bottom_height = '2',
    border_top_height = '2',
    border_left_color = my_border_color,
    border_right_color = my_border_color,
    border_bottom_color = my_border_color,
    border_top_color = my_border_color,
  },
}

return config
