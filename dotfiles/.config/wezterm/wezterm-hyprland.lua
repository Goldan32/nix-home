local wezterm = require 'wezterm'
local my_dracula = wezterm.color.get_builtin_schemes()['Dracula']
my_dracula.background = '#202020'

-- Get hostname
local f = io.popen 'hostname'
local hostname = f:read '*a' or ''
f:close()
hostname = string.gsub(hostname, '\n$', '')
local my_wayland_enable = true
if hostname == 'pc' then
  my_wayland_enable = false
end

wezterm.on('update-right-status', function(window, pane)
  -- This event fires frequently.
  local cwd = pane:get_current_working_dir()
  if cwd then
    -- Define the path for the temporary state file.
    local temp_file_path = wezterm.home_dir .. '/.cache/wezterm_cwd'

    -- Open the file for writing and save the path.
    local file = io.open(temp_file_path, 'w')
    if file then
      file:write(cwd.path)
      file:close()
    end
  end
end)

local config = {
  enable_wayland = my_wayland_enable,
  default_prog = { 'zsh', '-l' },
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
  },
  enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = 'Disabled',
  front_end = 'OpenGL',
  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'ssh',
    'btop',
    'nohup',
  },
  window_decorations = 'NONE',
}

return config
