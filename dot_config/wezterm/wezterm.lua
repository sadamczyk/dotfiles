-- Set nice hotkeys up with this! https://wezfurlong.org/wezterm/config/keys.html#leader-key

local wezterm = require 'wezterm';

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = {"wsl.exe", "--exec", "/usr/bin/fish"}
elseif wezterm.target_triple == "x86_64-apple-darwin" then
  default_prog = {"/usr/local/bin/fish"}
else
  default_prog = {"fish"}
end

-- Automatically switch colorscheme based on OS appearance
-- https://wezfurlong.org/wezterm/config/lua/wezterm.gui/get_appearance.html
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  -- get_appearance currently bugged. https://github.com/wez/wezterm/issues/4985
  -- if wezterm.gui then
  --   return wezterm.gui.get_appearance()
  -- end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Light' then
    return "Solarized (light) (terminal.sexy)"
  else
    return "Solarized (dark) (terminal.sexy)"
  end
end

return {
  color_scheme = scheme_for_appearance(get_appearance()),
  default_prog = default_prog,
  exit_behavior = "Close", -- remove after new release, "CloseOnCleanExit" is the default!
  font_size = 11,
  font = wezterm.font 'DejaVu Sans Mono',
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- Disables ligatures, yuck. TODO: Is this needed? I think DejaVu Sans Mono doesn't support them anyway.
  initial_cols = 500,
  initial_rows = 500,
  window_close_confirmation = "NeverPrompt",
  keys = {
    {key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}}, -- don't confirm closing tabs
    {key="d", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal{domain = 'CurrentPaneDomain'}},
    {key="d", mods="CTRL|SHIFT|ALT", action=wezterm.action.SplitVertical{domain = 'CurrentPaneDomain'}},
  },
}

-- Add this option when new release comes out!
--  clean_exit_codes = {130}, -- allows ^D after ^C (exit code >0 from last command) in zsh without annoying message
